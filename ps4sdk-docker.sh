#!/bin/sh

if [ ! -z "$*" ]; then
  docker run -v `pwd`:/build --rm -it --192.168.1.83 ps4sdk-docker $*
else
  docker run -v `pwd`:/build --rm -it --192.168.1.83 ps4sdk-docker
fi
