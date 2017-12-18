# musl-cross-make-toybox/Dockerfile

# from ubuntu
from alpine
maintainer Neil Roza <nroza@rethinkrobotics.com>
# env DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
workdir /workdir
# run apt-get -y update && apt-get -y install build-essential curl
run apk update && apk add curl alpine-sdk
# run apk update && apk add ca-certificates curl make
copy . .
run ./build --raw
