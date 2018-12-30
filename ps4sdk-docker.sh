#!/bin/sh

if [ ! -z "$*" ]; then
  docker run -v `pwd`:/build --rm -it --net host ps4sdk-docker $*
else
  docker run -v `pwd`:/build --rm -it --net host ps4sdk-docker
fi
