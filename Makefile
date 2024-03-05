CATALA ?= catala
CLERK ?= clerk

BUILD = _build

CATALA_INCLUDE = base_mensuelle_allocations_familiales:smic:prologue_france:prestations_familiales:allocations_familiales:aides_logement:droit_successions
export CATALA_INCLUDE

CATALA_OPTS ?= -t
CLERK_OPTS ?= --build-dir=$(BUILD) --makeflags="$(MAKEFLAGS)"

CLERK_TEST = $(CLERK) test $(CLERK_OPTS) $(if $(CATALA_OPTS),--catala-opts=$(CATALA_OPTS),)

OPAM = opam --cli=2.1

OCAMLC_FLAGS = -g $(addprefix -I _build/,$(subst :, , $(CATALA_INCLUDE)))

OCAMLC = $(ocamlfind ocamlc -only-show -package catala.runtime_ocaml)

JSOO_FLAGS = --pretty --source-map-inline --no-extern-fs --target-env=nodejs

# OCAMLC_FLAGS = \
#   $(shell ocamlfind query -r -i-format catala.runtime_jsoo) \
#   $(addprefix -I _build/,$(subst :, , $(CATALA_INCLUDE)))

TARGETS := allocations_familiales/allocations_familiales.py \
           allocations_familiales/allocations_familiales.cmxs \
           allocations_familiales/allocations_familiales_web.js \
           allocations_familiales/allocations_familiales_web_schema.json \
           aides_logement/aides_logement.py \
           aides_logement/aides_logement.cmxs \
           aides_logement/aides_logement_web.js \
           aides_logement/aides_logement_web_schema.json \
           allocations_familiales/allocations_familiales.tex \
           allocations_familiales/allocations_familiales.html \
           polish_taxes/polish_taxes.tex \
           polish_taxes/polish_taxes.html \
           tutorial_en/tutorial_en.tex \
           tutorial_en/tutorial_en.html \
           tutoriel_fr/tutoriel_fr.tex \
           tutoriel_fr/tutoriel_fr.html \
           us_tax_code/us_tax_code.tex \
           us_tax_code/us_tax_code.html \
           aides_logement/aides_logement.tex \
           aides_logement/aides_logement.html

TARGETS := $(addprefix $(BUILD)/,$(TARGETS))

all: $(TARGETS)

$(BUILD)/%.tex: %.catala_*
	$(CATALA) latex $(CATALA_OPTS) $^ -o $@

$(BUILD)/%.html: %.catala_*
	$(CATALA) html $(CATALA_OPTS) $^ -o $@

$(BUILD)/%.cmxs: %.catala_*
	$(CLERK) build $(CLERK_OPTS) $@

$(BUILD)/%.py: %.catala_*
	$(CLERK) build $(CLERK_OPTS) $@

$(BUILD)/%.cmo $(BUILD)/%.cmxs: %.catala_*
	$(CLERK) build $(CLERK_OPTS) $(*F)@module

$(BUILD)/%_api_web.ml: %.catala_* | $(BUILD)/%.cmo
	$(CATALA) api_web $(CATALA_OPTS) $^ -o $@

$(BUILD)/%.cma: $(BUILD)/%.cmo
	$(OCAMLC) $(OCAMLC_FLAGS) -a $^ -o $@

$(BUILD)/%.bc: $(BUILD)/%.cmo $(BUILD)/%_api_web.ml
	ocamlfind ocamlc -linkpkg \
	  -package catala.runtime_jsoo,js_of_ocaml-ppx \
	  $(OCAMLC_FLAGS) \
	  $$($(CATALA) depends $(CATALA_OPTS) \
	                       --prefix=$(BUILD) --extension=cmo \
	                       $(BUILD)/$*.catala_*) \
	  $^ -o $@

$(BUILD)/%.js: $(BUILD)/%.bc
	js_of_ocaml compile $(JSOO_FLAGS) $^ -o $@

$(BUILD)/allocations_familiales/Allocations_familiales_api_web.cma: \
  $(BUILD)/allocations_familiales/Allocations_familiales_api_web.ml \
  $(BUILD)/allocations_familiales/Allocations_familiales.cma
	$(OCAMLC) $(OCAMLC_FLAGS) -a $^ -o $@

build:
	$(CLERK) build $(CLERK_OPTS) \
	  Allocations_familiales@module \
	  Aides_logement@module \
	  _build/allocations_familiales/Allocations_familiales.py \
	  _build/aides_logement/Aides_logement.py

$(BUILD)/%_schema.json:


	dune build @install --promote-install-files

install: build
	@if [ x$$($(OPAM) --version) = "x2.1.5" ]; then \
	  $(OPAM) install . --working-dir; \
	else \
	  $(OPAM) install . --working-dir --assume-built; \
	fi

clean: .FORCE
	rm -rf _build

################################
# Running legislation unit tests
################################

test:
	$(CLERK_TEST)

TEST_FLAGS_LIST = "" --lcalc,--avoid-exceptions,-O

testsuite: .FORCE
	@for F in $(TEST_FLAGS_LIST); do \
	  echo >&2; \
	  [ -z "$$F" ] || echo ">> RE-RUNNING TESTS WITH FLAGS: $$F" >&2; \
	  $(CLERK_TEST) --test-flags="$$F" || break; \
	done

pass_all_tests: testsuite

reset_all_tests:
	$(CLERK_TEST) --reset

.FORCE:

.PHONY: pass_all_tests reset_all_tests
