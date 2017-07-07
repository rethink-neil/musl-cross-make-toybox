# musl-cross-make-toybox/Dockerfile

from ubuntu
maintainer Neil Roza <nroza@rethinkrobotics.com>
env DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
workdir /workdir
copy run run
run \
  set -euvx \
  && apt-get -y update \
  && apt-get -y install build-essential curl wget \
  && ./run
