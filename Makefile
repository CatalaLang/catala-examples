CLERK ?= clerk

CATALA_OPTS ?=
CLERK_OPTS ?= --makeflags="$(MAKEFLAGS)"

CLERK_TEST = $(CLERK) test $(CLERK_OPTS) $(if $(CATALA_OPTS),--catala-opts=$(CATALA_OPTS),)

all: literate_examples
	dune build @install

################################
# Running legislation unit tests
################################

pass_all_tests:
	$(CLERK_TEST)

reset_all_tests: CLERK_OPTS+=--reset
reset_all_tests:
	$(CLERK_TEST)

%.catala_en %.catala_fr %.catala_pl: .FORCE
	$(CLERK_TEST) ./$@

##########################################
# Literate programming and examples
##########################################

EXAMPLES_DIR = .
ALLOCATIONS_FAMILIALES_DIR = $(EXAMPLES_DIR)/allocations_familiales
AIDES_LOGEMENT_DIR = $(EXAMPLES_DIR)/aides_logement
US_TAX_CODE_DIR = $(EXAMPLES_DIR)/us_tax_code
TUTORIAL_EN_DIR = $(EXAMPLES_DIR)/tutorial_en
TUTORIEL_FR_DIR = $(EXAMPLES_DIR)/tutoriel_fr
POLISH_TAXES_DIR = $(EXAMPLES_DIR)/polish_taxes

literate_aides_logement:
	$(MAKE) -C $(AIDES_LOGEMENT_DIR) aides_logement.tex
	$(MAKE) -C $(AIDES_LOGEMENT_DIR) aides_logement.html

literate_allocations_familiales:
	$(MAKE) -C $(ALLOCATIONS_FAMILIALES_DIR) allocations_familiales.tex
	$(MAKE) -C $(ALLOCATIONS_FAMILIALES_DIR) allocations_familiales.html

literate_us_tax_code:
	$(MAKE) -C $(US_TAX_CODE_DIR) us_tax_code.tex
	$(MAKE) -C $(US_TAX_CODE_DIR) us_tax_code.html

literate_tutorial_en:
	$(MAKE) -C $(TUTORIAL_EN_DIR) tutorial_en.tex
	$(MAKE) -C $(TUTORIAL_EN_DIR) tutorial_en.html

literate_tutoriel_fr:
	$(MAKE) -C $(TUTORIEL_FR_DIR) tutoriel_fr.tex
	$(MAKE) -C $(TUTORIEL_FR_DIR) tutoriel_fr.html

literate_polish_taxes:
	$(MAKE) -C $(POLISH_TAXES_DIR) polish_taxes.tex
	$(MAKE) -C $(POLISH_TAXES_DIR) polish_taxes.html

#> literate_examples			: Builds the .tex and .html versions of the examples code. Needs pygments to be installed and patched with Catala.
literate_examples: literate_allocations_familiales \
	literate_us_tax_code literate_tutorial_en literate_tutoriel_fr \
	literate_polish_taxes literate_aides_logement

#-----------------------------------------
# JSON schemas
#-----------------------------------------

JSON_SCHEMAS = \
  $(AIDES_LOGEMENT_DIR)/aides_logement_schema.json \
  $(ALLOCATIONS_FAMILIALES_DIR)/allocations_familiales_schema.json

#> generate_french_law_json_schemas	: Generates the French law library JSON schemas
$(addprefix _build/default/,$(JSON_SCHEMAS)):
	dune $@

generate_french_law_json_schemas:
	dune build $(JSON_SCHEMAS)

.FORCE:

.PHONY: pass_all_tests reset_all_tests
