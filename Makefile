CLERK ?= clerk

CATALA_OPTS ?=
CLERK_OPTS ?= --makeflags="$(MAKEFLAGS)"

CLERK_TEST = $(CLERK) test $(CLERK_OPTS) $(if $(CATALA_OPTS),--catala-opts=$(CATALA_OPTS),)

all:
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

.FORCE:

.PHONY: pass_all_tests reset_all_tests
