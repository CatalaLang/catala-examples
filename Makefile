CLERK ?= clerk

CATALA_OPTS ?=
CLERK_OPTS ?= --makeflags="$(MAKEFLAGS)"

CLERK_TEST = $(CLERK) test $(CLERK_OPTS) $(if $(CATALA_OPTS),--catala-opts=$(CATALA_OPTS),)

OPAM = opam --cli=2.1

build:
	dune build @install --promote-install-files

install: build
	if [ x$$($(OPAM) --version) = "x2.1.5" ]; then \
	  $(OPAM) install . --working-dir; \
	else \
	  $(OPAM) install . --working-dir --assume-built; \
	fi

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

%.catala_en %.catala_fr %.catala_pl: .FORCE
	$(CLERK_TEST) ./$@

.FORCE:

.PHONY: pass_all_tests reset_all_tests
