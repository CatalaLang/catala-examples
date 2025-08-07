CATALA ?= catala
CLERK ?= clerk

BUILD = _build

# Tests use a separate build directory because they may need different flags
# (e.g. no --trace) and the objects would otherwise overwrite the main ones
BUILD_TESTS = _build/clerk_tests

VERSION = 1.0.0~alpha

#############################################
# Compiler and build tools commands and flags
#############################################

CATALA_INCLUDE := base_mensuelle_allocations_familiales:smic:prologue_france:prestations_familiales:allocations_familiales:aides_logement:droit_successions

CATALA_FLAGS ?= --trace
CLERK_FLAGS ?= --exe=$(CATALA)

CLERK_BUILD = $(CLERK) build --build-dir=$(BUILD) $(if $(CATALA_FLAGS),--catala-opts='$(CATALA_FLAGS)',) $(CLERK_FLAGS)

CLERK_TEST = $(CLERK) test $(CLERK_FLAGS) --build-dir=$(BUILD_TESTS)

OPAM = opam --cli=2.1

OCAMLC = ocamlfind ocamlc -package catala.runtime_ocaml
OCAMLOPT = ocamlfind ocamlopt -package catala.runtime_ocaml

JSOO_FLAGS = --pretty --source-map-inline --no-extern-fs

CATALA_DEPENDS = $(CATALA) depends -I $(CATALA_INCLUDE) --prefix=$(BUILD)

OCAML_FLAGS = -g

#######################
# List of build targets
#######################

NODOC ?=

DOC_SUFFIXES := $(if $(NODOC),,.tex .html)
LIB_SUFFIXES := $(DOC_SUFFIXES) .py .cma .cmxs .cmxa _schema.json

TARGET_LIBS = \
  allocations_familiales/Allocations_familiales \
  aides_logement/Aides_logement

TARGET_DOCS = \
  polish_taxes/polish_taxes \
  us_tax_code/us_tax_code

TARGETS := \
  $(foreach lib,$(TARGET_LIBS),$(addprefix $(lib),$(LIB_SUFFIXES))) \
  $(foreach lib,$(TARGET_DOCS),$(addprefix $(lib),$(DOC_SUFFIXES)))

FRENCH_LAW_TARGETS := \
  french_law_python.tar.gz \
  french-law_npm.tar.gz

all: \
  $(addprefix $(BUILD)/,$(TARGETS)) \
  $(addprefix $(BUILD)/,$(FRENCH_LAW_TARGETS)) \
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
	$(CATALA) latex $^ $(CATALA_FLAGS) -o $@ --wrap

$(BUILD)/%.html: %.catala_??
	$(CATALA) html $^ $(CATALA_FLAGS) -o $@ --wrap

##########################
# Rules: OCaml compilation
##########################

$(BUILD)/%.cmi: %.catala_??
	$(CLERK_BUILD) $(@D)/ocaml/$(@F)
$(BUILD)/%.cmo: %.catala_??
	$(CLERK_BUILD) $(@D)/ocaml/$(@F)
$(BUILD)/%.cmx: %.catala_??
	$(CLERK_BUILD) $(@D)/ocaml/$(@F)
$(BUILD)/%.cmxs: %.catala_??
	$(CLERK_BUILD) $(@D)/ocaml/$(@F)
# $(BUILD)/%.exe: %.catala_??
# 	$(CLERK_BUILD) $(@D)/ocaml/$(@F)

$(BUILD)/%.cma: $(BUILD)/%.cmi
	$(OCAMLC) $(OCAML_FLAGS) \
	  $(shell $(CATALA_DEPENDS) --subdir=ocaml --extension=cmo $(BUILD)/../$*.catala_??) \
	  -intf-suffix .ml \
	  -a -o $@

$(BUILD)/%.cmxa: $(BUILD)/%.cmi
	$(OCAMLOPT) $(OCAML_FLAGS) \
	  $(shell $(CATALA_DEPENDS) --subdir=ocaml --extension=cmx $(BUILD)/../$*.catala_??) \
	  -intf-suffix .ml \
	  -a -o $@
	# clerk link x.catala_x --srcext cmo -- ocamlopt -a -o xxx ??

###############################################
# Rules: api_web and compilation of JS packages
###############################################

$(BUILD)/%_api_web.ml: %.catala_?? | $(BUILD)/%.cmo
	$(CATALA) api_web -I $(CATALA_INCLUDE) $^ $(CATALA_FLAGS) -o $@

$(BUILD)/%-web.bc:
	$(if $^,,$(error Building a js bundle ($@) requires expliciting the expected contents))
	$(eval MLDEPS = $(shell $(CATALA_DEPENDS) --subdir=ocaml --extension=cmo $^))
	$(eval API = $(patsubst %,$(BUILD)/%_api_web.ml,$(basename $^)))
	$(CLERK_BUILD) $(MLDEPS)
	$(MAKE) $(API)
	ocamlfind ocamlc -linkpkg \
	  -package catala.runtime_jsoo,js_of_ocaml-ppx \
	  $(OCAML_FLAGS) \
	  $(patsubst %,-I $(BUILD)/%/ocaml,$(subst :, , $(CATALA_INCLUDE))) \
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
	$(CATALA) json_schema -I $(CATALA_INCLUDE) $^ -o $@ --scope=$(SCOPE)

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
	$(eval PYDEPS = $(shell $(CATALA_DEPENDS) --subdir=python --extension=py $^))
	@mkdir -p $(BUILD)/python/$(*F)/$(*F)
	$(CLERK_BUILD) $(PYDEPS)
	cp $(PYDEPS) $(BUILD)/python/$(*F)/$(*F)
	echo '__all__ = [$(foreach f,$(PYDEPS),"$(notdir $(basename $f))",)]' \
	  >$(BUILD)/python/$(*F)/$(*F)/__init__.py
	touch $(BUILD)/python/$(*F)/$(*F)/py.typed
	$(file >$(BUILD)/$(*F).toml,$(call pyproject_toml,$(*F)))
	mv $(BUILD)/$(*F).toml $(BUILD)/python/$(*F)/pyproject.toml
	tar czf $@ -C $(BUILD)/python $(*F)

$(BUILD)/french_law_python.tar.gz: $(TARGET_LIBS:=.catala_??) | $(BUILD)

##############
# Installation
##############

INSTALL_lib = $(filter %.cma %.cmxa %.a %.js %_schema.json, $(TARGETS))
INSTALL_libexec = $(filter %.cmxs, $(TARGETS))
INSTALL_doc = $(filter %.txt %.md %.tex %.html, $(TARGETS))

# Install specification file as expected by opam
catala-examples.install: $(TARGET_LIBS:=.catala_??)
	@{ \
	  echo "lib: ["; \
	  echo "  \"META\""; \
	  $(foreach lib,$(TARGET_LIBS),\
	    $(foreach ext,.ml .mli,\
	      echo "  \"$(BUILD)/$(dir $(lib))ocaml/$(notdir $(lib))$(ext)\" {\"$(lib)$(ext)\"}"; )\
	    $(foreach ext,.a .cma .cmxa _schema.json,\
	      echo "  \"$(BUILD)/$(lib)$(ext)\" {\"$(lib)$(ext)\"}"; )\
	    $(foreach f,$(shell catala depends -I $(CATALA_INCLUDE) --extension= $(lib).catala_??),\
	      echo "  \"$(BUILD)/$(dir $f)ocaml/$(notdir $f).mli\" {\"$(dir $(lib))$(notdir $f.mli)\"}"; \
	      echo "  \"$(BUILD)/$(dir $f)ocaml/$(notdir $f).cmi\" {\"$(dir $(lib))$(notdir $f.cmi)\"}"; )\
	  ) \
	  $(foreach f,$(FRENCH_LAW_TARGETS),echo "  \"$(BUILD)/$f\" {\"$f\"}"; )\
	  echo "]"; \
	  echo "libexec: ["; \
	  $(foreach f,$(INSTALL_libexec),echo "  \"$(BUILD)/$(dir $f)/ocaml/$(notdir $f)\" {\"$f\"}";) \
	  echo "]"; \
	  echo "doc: ["; \
	  echo "  \"LICENSE.txt\""; \
	  echo "  \"README.md\""; \
	  $(foreach f,$(INSTALL_doc),echo "  \"$(BUILD)/$f\" {\"$f\"}";) \
	  echo "]"; \
	} >$@

INSTALL_PREFIX ?= $(realpath $(shell ocamlfind query catala)/../..)

local-install: all
	$(if $(INSTALL_PREFIX),,$(error Could not determine INSTALL_PREFIX for installation))
	opam-installer --prefix=$(INSTALL_PREFIX)

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

TEST_DIRS = \
  prestations_familiales/tests \
  allocations_familiales/tests \
  aides_logement/tests \
  droit_successions/tests \
  aides_logement/tests \
  polish_taxes/tests \
  NSW_community_gaming/tests \
  us_tax_code/tests

# impot_revenu/tests is excluded because only supported for OCaml

interp-tests:
	$(CLERK_TEST)

binary-tests:
	$(CLERK_TEST) --backend ocaml
	$(CLERK_TEST) $(TEST_DIRS) --backend c
	$(CLERK_TEST) $(TEST_DIRS) --backend python
#	$(CLERK_TEST) $(TEST_DIRS) --backend java
	@echo "$(CURDIR): all binary tests passed"

test: .FORCE interp-tests binary-tests
tests: test

TEST_FLAGS_LIST = "" --lcalc,-O

testsuite1: .FORCE
	@for F in $(TEST_FLAGS_LIST); do \
	  echo >&2; \
	  [ -z "$$F" ] || echo ">> RE-RUNNING TESTS WITH FLAGS: $$F" >&2; \
	  echo $(CLERK_TEST) --test-flags="$$F"; \
	  $(CLERK_TEST) --test-flags="$$F" || exit 1; \
	done

testsuite: testsuite1 binary-tests
pass_all_tests: testsuite

reset_all_tests:
	$(CLERK_TEST) --reset

.FORCE:

.PHONY: all pass_all_tests reset_all_tests

# Disables make removing intermediate files
.SECONDARY:
