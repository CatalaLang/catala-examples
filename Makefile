CATALA ?= catala
CLERK ?= clerk

BUILD = _build

# Tests use a separate build directory because they may need different flags
# (e.g. no --trace) and the objects would otherwise overwrite the main ones
BUILD_TESTS = _build/clerk_tests

VERSION = 1.0.0~alpha
PYTHON_VERSION=1.0.0a

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

all: targets ocaml-libs python-libs

targets:
	$(CLERK_BUILD)

tests_interp:
	$(CLERK_TEST)

# OCAML

ocaml_tests:
	$(CLERK_TEST) --backend=ocaml

# PYTHON

python_tests:
	$(CLERK_TEST) --backend=python allocations-familiales aides-logement

# C

c_tests:
	$(CLERK_TEST) --backend=c allocations-familiales aides-logement

# JAVA

java_tests:
	$(CLERK_TEST) --backend=java allocations-familiales aides-logement

binary-tests: ocaml_tests python_tests c_tests java_tests
test: .FORCE tests_interp binary-tests
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


###############################
# Catala rules: literate output
###############################

DOC_SUFFIXES := $(if $(NODOC),,.tex .html)

TARGET_DOCS = \
  allocations_familiales/Allocations_familiales \
  aides_logement/Aides_logement \
  polish_taxes/polish_taxes \
  us_tax_code/us_tax_code

doc: $(foreach lib,$(TARGET_DOCS),$(addprefix $(lib),$(DOC_SUFFIXES)))

# Note: this generates the literate output only for a single file at the moment,
# excluding modules (and this rule is only run for the listed targets).
# Clerk will handle this at some point

$(BUILD)/%.tex: %.catala_??
	$(CATALA) latex $^ $(CATALA_FLAGS) -o $@ --wrap

$(BUILD)/%.html: %.catala_??
	$(CATALA) html $^ $(CATALA_FLAGS) -o $@ --wrap

##########################
# Rules: OCaml compilation
##########################

_targets/%.cmxa: targets
	ocamlmklib _targets/$*/ocaml/*.cmx -o _targets/$*

ocaml-libs: _targets/allocations-familiales.cmxa _targets/aides-logement.cmxa _targets/impot-revenu.cmxa


################################################
# Rule for python, and python project generation
################################################

define pyproject_toml
[project]
name = "$1"
description = "Examples of law texts compiled from catala code"
version = "$(PYTHON_VERSION)"
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

_targets/%_python.tar.gz: targets
	@mkdir -p $(BUILD)/python/$*/$*
	cp _targets/$*/python/* $(BUILD)/python/$*/$*/
	echo '__all__ = [$(foreach f,$(wildcard _targets/$*/python/*),"$(notdir $(basename $f))",)]' \
	  >$(BUILD)/python/$*/$*/__init__.py
	touch $(BUILD)/python/$*/$*/py.typed
	$(file >$(BUILD)/$*.toml,$(call pyproject_toml,$*))
	mv $(BUILD)/$*.toml $(BUILD)/python/$*/pyproject.toml
	tar czf $@ -C $(BUILD)/python $*

python-libs: _targets/allocations-familiales_python.tar.gz _targets/aides-logement_python.tar.gz


clean: .FORCE
	rm -rf catala-examples.install _build _targets

############################################
# Checking the formatting of the Catala code
############################################

CATALA_SRC=$(shell find . -path ./_build -prune -o -type f -name '*.catala_*' -print)

%.catala_pl.format: %.catala_pl
	catala-format $< | diff -u $< -
%.catala_en.format: %.catala_en
	catala-format $< | diff -u $< -
%.catala_fr.format: %.catala_fr
	catala-format $< | diff -u $< -

check-format: $(addsuffix .format,$(CATALA_SRC))

.FORCE:

.PHONY: all pass_all_tests reset_all_tests check-format

# Disables make removing intermediate files
.SECONDARY:
