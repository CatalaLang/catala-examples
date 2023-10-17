# Catala examples

This repository contains examples of Catala programs. It is highly recommended
to locate your own Catala programs in this directory, since programs in this
directory will receive first-class support during the alpha and beta stage
of the Catala programming language development.

<strong>[Browse examples online »](https://catala-lang.org/en/examples)</strong>

## List of examples

- `allocations_familiales/`: computation of the French family benefits, based
  on the _Code de la sécurité sociale_.
- `aides_logement`: computation of the French housing benefits, based on the
  _Code de la construction et de l'habitation_. This case study is the biggest and
  most ambitious for Catala so far.
- `tutorial_<en/fr>/`: Catala language tutorial for developers of tech-savvy lawyers.
  The tutorial is written like a piece of legislation that gets annotated by
  Catala snippets.
- `us_tax_code/`: contains the Catala formalization of several sections of the
  US Tax Code.

## Building and running examples

Use [Clerk](https://catalalang.github.io/catala/clerk.html) (it come installed
alongside catala) to build and test your examples.

> Note: For now, the OCaml, Javascript and Python artifacts that as used in
> https://github.com/CatalaLang/french-law are generated using `dune` rules
> instead for now, while Clerk is getting mature enough. See the examples in
> `aides_logement/dune` and `allocations_familiales/dune`.

## Testing examples

Unit testing is important, and we encourage Catala developers to write lots
of tests for their programs. Again, the Makefile system provides a way to
collect tests into a regression test suite.

In order to enjoy the benefits of this system, we recommand that you create a
`tests/` directory in your examples directory, for instance `foo/tests`. Then,
create a test file `foo_tests.catala_en` inside that directory.

Inside `foo_tests.catala_en`, declare one ore more test scopes. Then, you can
provide the expected output for the interpretation of these scopes or the
compilation of the whole program using the standard expected by `clerk test` by
including `catala-test-inline` sections in your file.

Once your tests are written, then will automatically be added to the regression
suite executed using:

    clerk test

You can isolate a part of the regression suite by invoking:

    clerk test foo/tests/foo_tests.catala_en

## Adding an example

This section describes what to do to setup a working directory for a new Catala
example, as well as the development cycle. Let us suppose that you want to
create a new example named `foo`.

First, follow the instructions to install the Catala compiler. You can also set
up the syntax highlighting for your editor.

Then, create the directory `examples/foo`. In there, create a master source
file `foo.catala_en` (or `foo.catala_fr`, etc. depending on your language)
that will be the root of your Catala program. You can then start programming
in `foo.catala_en`, or split up your example into multiple files. In the later case,
`foo.catala_en` must only contain
something like this:

```markdown
# Master file

> Include: bar.catala_en
```

where `examples/bar.catala_en` is another source file containing code for your
example. Make sure you start by including some content in the source files,
like

```
Hello, world!
```
