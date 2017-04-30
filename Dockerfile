FROM alpine

RUN \
  set -euvx \
  && apk update \
  && apk add ca-certificates curl make wget

WORKDIR /workdir

copy . .

run \
  set -euvx \
  && ./github-get-latest https://github.com/richfelker/musl-cross-make \
  && cd musl-cross-make \
  && echo 'TARGET=x86_64-linux-musl' >config.mak \
  && make -j$(getconf _NPROCESSORS_ONLN) install

run \
  set -euvx \
  && ./github-get-latest https://github.com/landley/toybox \
  && cd toybox \
  && export CROSS_COMPILE="x86_64-linux-musl-" \
  && export PATH=/workdir/musl-cross-make/output/bin:${PATH} \
  && export CFLAGS="--static" \
  && export LDFLAGS="--static" \
  && make defconfig all



#   && checkinstall \
#     -y \
#     --addso=no \
#     --maintainer=$(whoami)@rethinkrobotics.com \
#     --pkglicense=BSD \
#     --pkgname=toybox \
#     --pkgrelease=1 \
#     --pkgversion=${VERSION} \
#     --type=debian \
#     make install
