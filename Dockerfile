# musl-cross-make-toybox

from alpine

run apk update && apk add alpine-sdk bash

workdir /workdir

copy ./github-get-latest .

run \
  set -eu \
  && ./github-get-latest https://github.com/richfelker/musl-cross-make \
  && echo 'TARGET=x86_64-linux-musl' >musl-cross-make/config.mak \
  && make -C musl-cross-make -j $(getconf _NPROCESSORS_ONLN) all \
  && make -C musl-cross-make install

run \
  set -eu \
  && ./github-get-latest https://github.com/landley/toybox \
  && export CROSS_COMPILE="x86_64-linux-musl-" \
  && export PATH=/workdir/musl-cross-make/output/bin:${PATH} \
  && export CFLAGS="--static" \
  && export LDFLAGS="--static" \
  && make -C toybox -j $(getconf _NPROCESSORS_ONLN) defconfig all \
  && make -C toybox install
