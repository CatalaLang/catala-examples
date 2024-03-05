CATALA ?= catala
CLERK ?= clerk

BUILD = _build

#############################################
# Compiler and build tools commands and flags
#############################################

CATALA_INCLUDE := base_mensuelle_allocations_familiales:smic:prologue_france:prestations_familiales:allocations_familiales:aides_logement:droit_successions
export CATALA_INCLUDE

CATALA_FLAGS ?=
CLERK_FLAGS ?= --build-dir=$(BUILD) --makeflags="$(MAKEFLAGS)"

CLERK_TEST = $(CLERK) test $(CLERK_FLAGS) $(if $(CATALA_FLAGS),--catala-opts=$(CATALA_FLAGS),)

OPAM = opam --cli=2.1

OCAMLC = $(shell ocamlfind ocamlc -only-show -package catala.runtime_ocaml)
OCAMLOPT = $(shell ocamlfind ocamlopt -only-show -package catala.runtime_ocaml)

JSOO_FLAGS = --pretty --source-map-inline --no-extern-fs

CATALA_DEPENDS = $(CATALA) depends -I $(CATALA_INCLUDE) $(CATALA_FLAGS) --prefix=$(BUILD)

OCAML_FLAGS = -g \
  $(shell ocamlfind query -r -i-format catala.runtime_jsoo) \
  $(addprefix -I _build/,$(subst :, , $(CATALA_INCLUDE)))

#######################
# List of build targets
#######################

DOC_SUFFIXES := .tex .html
LIB_SUFFIXES := $(DOC_SUFFIXES) .py .cma .cmxs .cmxa .js _schema.json

TARGET_LIBS = \
  allocations_familiales/Allocations_familiales \
  aides_logement/Aides_logement

TARGET_DOCS = \
  polish_taxes/polish_taxes \
  tutorial_en/tutorial_en \
  tutoriel_fr/tutoriel_fr \
  us_tax_code/us_tax_code

TARGETS := \
  $(foreach lib,$(TARGET_LIBS),$(addprefix $(lib),$(LIB_SUFFIXES))) \
  $(foreach lib,$(TARGET_DOCS),$(addprefix $(lib),$(DOC_SUFFIXES)))

all: \
  $(addprefix $(BUILD)/,$(TARGETS)) \
  $(patsubst %,$(BUILD)/%_python.tar,$(TARGET_LIBS)) \
  catala-examples.install

###############################
# Catala rules: literate output
###############################

# Note: this generates the literate output only for a single file at the moment,
# excluding modules (and this rule is only run for the listed targets). We could
# run `catala latex $^ $(catala depends $^)` to include all dependencies.

$(BUILD)/%.tex: %.catala_??
	$(CATALA) latex $(CATALA_FLAGS) $^ -o $@

$(BUILD)/%.html: %.catala_??
	$(CATALA) html $(CATALA_FLAGS) $^ -o $@

##########################
# Rules: OCaml compilation
##########################

$(BUILD)/%.cmi $(BUILD)/%.cmo $(BUILD)/%.cmx $(BUILD)/%.cmxs $(BUILD)/%.exe: %.catala_??
	$(CLERK) build $(CLERK_FLAGS) $@
# Clerk target equvalent to $(*F)@module

$(BUILD)/%.cma: $(BUILD)/%.cmo
	$(OCAMLC) $(OCAML_FLAGS) \
	  $(shell $(CATALA_DEPENDS) --extension=cmo $(BUILD)/$*.catala_??) \
	  -a $^ -o $@

$(BUILD)/%.cmxa: $(BUILD)/%.cmx
	$(OCAMLOPT) $(OCAML_FLAGS) \
	  $(shell $(CATALA_DEPENDS) --extension=cmx $(BUILD)/$*.catala_??) \
	  -a $^ -o $@

##############################################
# Rules: api_web and compilation of JS modules
##############################################

$(BUILD)/%_api_web.ml: %.catala_?? | $(BUILD)/%.cmo
	$(CATALA) api_web $(CATALA_FLAGS) $^ -o $@

$(BUILD)/%-web.bc: $(BUILD)/%.cmo $(BUILD)/%_api_web.ml
	ocamlfind ocamlc -linkpkg \
	  -package catala.runtime_jsoo,js_of_ocaml-ppx \
	  $(OCAML_FLAGS) \
	  $(shell $(CATALA_DEPENDS) --extension=cmo $(BUILD)/$*.catala_??) \
	  -I $(BUILD)/$(*D) \
	  $^ -o $@

$(BUILD)/%.js: $(BUILD)/%-web.bc
	js_of_ocaml compile $(JSOO_FLAGS) \
	  $$(ocamlfind query -format "%+(jsoo_runtime)" -r catala.runtime_jsoo) \
	  $^ -o $@

# Needs specific definition for SCOPE, see the explicit rules below
$(BUILD)/%_schema.json: %.catala_??
	$(CATALA) json_schema $^ -o $@ --scope=$(SCOPE)

$(BUILD)/aides_logement/Aides_logement_schema.json: \
  SCOPE=CalculetteAidesAuLogementGardeAlternée
$(BUILD)/allocations_familiales/Allocations_familiales_schema.json: \
  SCOPE=InterfaceAllocationsFamiliales

################################################
# Rule for python, and python project generation
################################################

$(BUILD)/%.py: %.catala_??
	$(CLERK) build $(CLERK_FLAGS) $@


define pyproject_toml
[project]
name = "$1"
description = "Examples of law texts compiled from catala code"
version = "0.9.0"
dependencies = [ "catala-runtime" ]

[project.urls]
"Homepage" = "https://github.com/CatalaLang/catala-examples/"
"Bug Tracker" = "https://github.com/CatalaLang/catala/issues"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
endef

$(BUILD)/%_python.tar: $(BUILD)/%.py
	$(eval PYDEPS = $(shell $(CATALA_DEPENDS) --extension=py $*.catala_??))
	@mkdir -p $(@D)/python/$*
	$(CLERK) build $(CLERK_FLAGS) $(PYDEPS)
	cp $^ $(PYDEPS) $(@D)/python/$*
	echo '__all__ = [$(foreach f,$^ $(PYDEPS),"$(notdir $(basename $f))",)]' \
	  >$(@D)/python/$*/__init__.py
	touch $(@D)/python/$*/py.typed
	$(file >$(BUILD)/$*.toml,$(call pyproject_toml,$(*F)))
	mv $(BUILD)/$*.toml $(@D)/python/$(*D)/pyproject.toml
	tar cf $@ -C $(@D)/python $(*D)

# Note: the Aides_logement package will actually include all french_law code,
# since it depends on the whole Allocations_familiales. Maybe we could rename it
# and export as single "french_law" package

##############
# Installation
##############

INSTALL_lib = $(filter %.cma %.cmxa %.js %_schema.json, $(TARGETS))
INSTALL_libexec = $(filter %.cmxs, $(TARGETS))
INSTALL_doc = $(filter %.txt %.md %.tex %.html, $(TARGETS))

# Install specification file as expected by opam
catala-examples.install: $(TARGET_LIBS:=.catala_??)
	@{ \
	  echo "lib: ["; \
	  echo "  \"META\""; \
	  $(foreach lib,$(TARGET_LIBS),\
	    $(foreach ext,.a .ml .cmi .cmt .cmx .cma .cmxa .js _schema.json _python.tar,\
	      echo "  \"$(BUILD)/$(lib)$(ext)\" {\"$(lib)$(ext)\"}"; )\
	    $(foreach f,$(shell catala depends -I $(CATALA_INCLUDE) --extension=cmi $(lib).catala_??),\
	      echo "  \"$(BUILD)/$f\" {\"$(dir $(lib))$(notdir $f)\"}"; )\
	  ) \
	  echo "]"; \
	  echo "libexec: ["; \
	  $(foreach f,$(INSTALL_libexec),echo "  \"$(BUILD)/$f\" {\"$f\"}";) \
	  echo "]"; \
	  echo "doc: ["; \
	  echo "  \"LICENSE.txt\""; \
	  echo "  \"README.md\""; \
	  $(foreach f,$(INSTALL_doc),echo "  \"$(BUILD)/$f\" {\"$f\"}";) \
	  echo "]"; \
	} >$@

# Files to be installed are listed in the catala-examples.install file
install: all
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

test: $(BUILD)/allocations_familiales/tests/tests_allocations_familiales.exe
	$(CLERK_TEST)
	$^

TEST_FLAGS_LIST = "" --lcalc,--avoid-exceptions,-O

testsuite: $(BUILD)/allocations_familiales/tests/tests_allocations_familiales.exe .FORCE
	@for F in $(TEST_FLAGS_LIST); do \
	  echo >&2; \
	  [ -z "$$F" ] || echo ">> RE-RUNNING TESTS WITH FLAGS: $$F" >&2; \
	  echo $(CLERK_TEST) --test-flags="$$F"; \
	  $(CLERK_TEST) --test-flags="$$F" || break; \
	done
	@echo >&2
	@echo ">> RUNNING OCAML-NATIVE TESTS" >&2
	$<

pass_all_tests: testsuite

reset_all_tests:
	$(CLERK_TEST) --reset

.FORCE:

.PHONY: pass_all_tests reset_all_tests

# Disables make removing intermediate files
.SECONDARY:
