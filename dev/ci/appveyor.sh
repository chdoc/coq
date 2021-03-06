#!/bin/bash

set -e -x

APPVEYOR_OPAM_VARIANT=ocaml-variants.4.07.1+mingw64c

wget https://github.com/fdopen/opam-repository-mingw/releases/download/0.0.0.2/opam64.tar.xz -O opam64.tar.xz
tar -xf opam64.tar.xz
bash opam64/install.sh

opam init default -a -y "https://github.com/fdopen/opam-repository-mingw.git#opam2" -c $APPVEYOR_OPAM_VARIANT --disable-sandboxing
eval "$(opam env)"
opam install -y num ocamlfind ounit

# Full regular Coq Build
cd "$APPVEYOR_BUILD_FOLDER" && ./configure -local && make && make byte && make -C test-suite all INTERACTIVE= # && make validate
