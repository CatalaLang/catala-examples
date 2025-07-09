FROM docker.io/ocaml/opam:debian-12-ocaml-5.0

USER root

RUN apt-get update && apt-get install -y git ca-certificates libgmp-dev pkg-config ninja-build openjdk-17-jdk && rm -rf /var/lib/apt/lists/*

USER opam

RUN opam pin catala-lsp.dev git+https://github.com/CatalaLang/catala-language-server -y

CMD ["/bin/bash"]

