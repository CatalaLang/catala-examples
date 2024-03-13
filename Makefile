CATALA ?= catala
CLERK ?= clerk

BUILD = _build

VERSION = 0.9.0

#############################################
# Compiler and build tools commands and flags
#############################################

CATALA_INCLUDE := base_mensuelle_allocations_familiales:smic:prologue_france:prestations_familiales:allocations_familiales:aides_logement:droit_successions
export CATALA_INCLUDE

CATALA_FLAGS ?=
CLERK_FLAGS ?= --build-dir=$(BUILD) --makeflags="$(MAKEFLAGS)"

CLERK_BUILD = $(CLERK) build --catala-opts=--trace $(CLERK_FLAGS)

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
LIB_SUFFIXES := $(DOC_SUFFIXES) .py .cma .cmxs .cmxa _schema.json

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

FRENCH_LAW_SUFFIXES := _python.tar.gz _npm.tar.gz
FRENCH_LAW := $(addprefix $(BUILD)/french-law,$(FRENCH_LAW_SUFFIXES))

all: \
  $(addprefix $(BUILD)/,$(TARGETS)) \
  $(FRENCH_LAW) \
  catala-examples.install

$(BUILD):
	mkdir -p $@

###############################
# Catala rules: literate output
###############################

# Note: this generates the literate output only for a single file at the moment,
# excluding modules (and this rule is only run for the listed targets). We could
# run `catala latex $(catala depends $^)` to include all dependencies.

$(BUILD)/%.tex: %.catala_??
	$(CATALA) latex $(CATALA_FLAGS) $^ -o $@

$(BUILD)/%.html: %.catala_??
	$(CATALA) html $(CATALA_FLAGS) $^ -o $@

##########################
# Rules: OCaml compilation
##########################

$(BUILD)/%.cmi $(BUILD)/%.cmo $(BUILD)/%.cmx $(BUILD)/%.cmxs $(BUILD)/%.exe: %.catala_??
	$(CLERK_BUILD) $@
# Clerk target equivalent to $(*F)@module

$(BUILD)/%.cma: $(BUILD)/%.cmo
	$(OCAMLC) $(OCAML_FLAGS) \
	  $(shell $(CATALA_DEPENDS) --extension=cmo $(BUILD)/$*.catala_??) \
	  -a -o $@

$(BUILD)/%.cmxa: $(BUILD)/%.cmx
	$(OCAMLOPT) $(OCAML_FLAGS) \
	  $(shell $(CATALA_DEPENDS) --extension=cmx $(BUILD)/$*.catala_??) \
	  -a -o $@

###############################################
# Rules: api_web and compilation of JS packages
###############################################

$(BUILD)/%_api_web.ml: %.catala_?? | $(BUILD)/%.cmo
	$(CATALA) api_web $(CATALA_FLAGS) $^ -o $@

$(BUILD)/%-web.bc:
	$(if $^,,$(error Building a js bundle ($@) requires expliciting the expected contents))
	$(eval MLDEPS = $(shell $(CATALA_DEPENDS) --extension=cmo $^))
	$(eval API = $(patsubst %,$(BUILD)/%_api_web.ml,$(basename $^)))
	$(CLERK_BUILD) $(MLDEPS)
	$(MAKE) $(API)
	ocamlfind ocamlc -linkpkg \
	  -package catala.runtime_jsoo,js_of_ocaml-ppx \
	  $(OCAML_FLAGS) \
	  $(MLDEPS) \
	  $(API) \
	  -o $@

$(BUILD)/%.js: $(BUILD)/%-web.bc
	js_of_ocaml compile $(JSOO_FLAGS) \
	  $$(ocamlfind query -format "%+(jsoo_runtime)" -r catala.runtime_jsoo) \
	  $^ -o $@

$(BUILD)/french-law-web.bc: \
  allocations_familiales/Allocations_familiales.catala_fr \
  aides_logement/Aides_logement.catala_fr

$(BUILD)/%_schema.json: %.catala_??
	$(if $(SCOPE),,$(error Building a json schema ($@) requires an explicit scope))
	$(CATALA) json_schema $^ -o $@ --scope=$(SCOPE)

$(BUILD)/aides_logement/Aides_logement_schema.json: \
  SCOPE=CalculetteAidesAuLogementGardeAlternée
$(BUILD)/allocations_familiales/Allocations_familiales_schema.json: \
  SCOPE=InterfaceAllocationsFamiliales

###################################
# Rules for node package generation
###################################

define package_json
{
  "name": "@catala-lang/$1",
  "version": "$(VERSION)",
  "description": "Examples of law texts compiled from catala code",
  "main": "$1.js",
  "repository": "github:CatalaLang/catala-examples",
  "keywords": [ "catala", "law" ],
  "author": "Denis Merigoux <denis.merigoux@inria.fr>",
  "license": "Apache-2.0",
  "bugs": { "url": "https://github.com/CatalaLang/catala/issues" },
  "homepage": "https://github.com/CatalaLang/catala-examples"
}
endef

$(BUILD)/%_npm.tar.gz: $(BUILD)/%.js
	@mkdir -p $(BUILD)/npm/$(*F)
	cp $^ $(BUILD)/npm/$(*F)
	$(file >$(BUILD)/$(*F)_npm.json,$(call package_json,$(*F)))
	mv $(BUILD)/$(*F)_npm.json $(BUILD)/npm/$(*F)/package.json
	tar czf $@ -C $(BUILD)/npm $(*F)

################################################
# Rule for python, and python project generation
################################################

$(BUILD)/%.py: %.catala_??
	$(CLERK_BUILD) $@

define pyproject_toml
[project]
name = "$1"
description = "Examples of law texts compiled from catala code"
version = "$(VERSION)"
dependencies = [ "catala-runtime" ]

[project.urls]
"Homepage" = "https://github.com/CatalaLang/catala-examples/"
"Bug Tracker" = "https://github.com/CatalaLang/catala/issues"

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["$1"]
endef

$(BUILD)/%_python.tar.gz:
	$(if $^,,$(error Building a python package ($@) requires expliciting the expected contents))
	$(eval PYDEPS = $(shell $(CATALA_DEPENDS) --extension=py $^))
	@mkdir -p $(BUILD)/python/$(*F)/$(*F)
	$(CLERK_BUILD) $(PYDEPS)
	cp $(PYDEPS) $(BUILD)/python/$(*F)/$(*F)
	echo '__all__ = [$(foreach f,$(PYDEPS),"$(notdir $(basename $f))",)]' \
	  >$(BUILD)/python/$(*F)/$(*F)/__init__.py
	touch $(BUILD)/python/$(*F)/$(*F)/py.typed
	$(file >$(BUILD)/$(*F).toml,$(call pyproject_toml,$(*F)))
	mv $(BUILD)/$(*F).toml $(BUILD)/python/$(*F)/pyproject.toml
	tar czf $@ -C $(BUILD)/python $(*F)

$(BUILD)/french-law_python.tar.gz: $(TARGET_LIBS:=.catala_??) | $(BUILD)

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
	    $(foreach ext,.a .ml .cmi .cmt .cmx .cma .cmxa _schema.json,\
	      echo "  \"$(BUILD)/$(lib)$(ext)\" {\"$(lib)$(ext)\"}"; )\
	    $(foreach f,$(shell catala depends -I $(CATALA_INCLUDE) --extension=cmi $(lib).catala_??),\
	      echo "  \"$(BUILD)/$f\" {\"$(dir $(lib))$(notdir $f)\"}"; )\
	  ) \
	  $(foreach sfx,$(FRENCH_LAW_SUFFIXES),\
	    echo "  \"$(BUILD)/french-law$(sfx)\" {\"french-law$(sfx)\"}"; )\
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
	rm -rf catala-examples.install _build

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
