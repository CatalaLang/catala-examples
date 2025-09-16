# OCaml French Law Library

ready-to-use OCaml library featuring French public
algorithms coded up in Catala.


## Organization

This folder contains a thin wrapper with a simplified interface over the OCaml
version of the `Allocations_familiales`. The required dependencies are found in
the `catala-examples` package, which compiles the catala source and should
provide the OCaml library into
`<opam-prefix>/lib/catala-examples/allocations_familiales`.

The library should be available if `catala-examples` was installed properly, and
will be automatically picked up by the `dune` build specification.

Also provided, `bench.ml` provides a simple benchmarking executable that runs
the computations of each algorithm a bunch of times with random inputs. You can
run it from the root of this repository with

```
make run_french_law_library_benchmark_ocaml
```
