FROM ubuntu:17.10
MAINTAINER Naomi Peori <naomi@peori.ca>

ENV PS4DEV=/usr/local/ps4dev
ENV PS4SDK=$PS4DEV/ps4sdk
ENV LOCALIP=192.168.178.25
ENV PS4IP=192.168.178.27

RUN \
    apt-get -y update && \
    apt-get -y install nano tmux build-essential clang curl git && \
    apt-get -y clean autoclean autoremove && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y nodejs

RUN \
    mkdir -p ${PS4DEV} && \
    cd ${PS4DEV} && \
    git clone -b firmware505 https://github.com/psxdev/ps4sdk && \
    cd ps4sdk && \
    make -j

RUN \
    mkdir -p ${PS4DEV} && \
    cd ${PS4DEV} && \
    git clone https://github.com/orbisdev/liborbis.git && \
    cd liborbis && \
    cd libdebugnet && \
    make && \
    make install && \
    cd .. && \
    cd libelfloader && \
    make && \
    make install && \
    cd .. && \
    cd libps4link && \
    make && \
    make install && \
    cd .. && \
    cd liborbisPad && \
    make && \
    make install && \
    cd .. && \
    cd liborbisAudio && \
    make && \
    make install && \
    cd .. && \
    cd liborbisFile && \
    make && \
    make install && \
    cd .. && \
    cd libmod && \
    make && \
    make install && \
    cd .. && \
    cd portlibs && \
    cd libz && \
    make && \
    make install && \
    cd .. && \
    cd libpng && \
    make && \
    make install && \
    cd .. && \
    cd .. && \
    cd liborbis2d && \
    make && \
    make install && \
    cd .. && \
    cd liborbisFileBrowser && \
    make && \
    make install && \
    cd .. && \
    cd liborbisGl && \
    make && \
    make install && \
    cd .. && \
    cd liborbisXbmFont && \
    make && \
    make install && \
    cd .. && \
    cd liborbisKeyboard && \
    make && \
    make install

RUN \
    apt-get -y install libreadline-dev libncurses-dev && \
    mkdir -p ${PS4DEV} && \
    cd ${PS4DEV} && \
    git clone http://github.com/psxdev/ps4link && \
    cd ps4link && \
#    cd libdebugnet && \
#    make && \
#    make install && \
#    cd .. && \
#    cd libelfloader && \
#    make && \
#    make install && \
#    cd .. && \
#    cd libps4link && \
#    sed -i "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/$LOCALIP/g" ${PS4DEV}/ps4link/ps4link/source/main.c && \
#    make && \
#    make install && \
#    cd .. && \
#    cd elf-loader && \
#    ./copy_ps4link_sources.sh && \
#    make && \
#    cd .. && \
    cd ps4sh && \
    sed -i -e 's/dst_ip\[16\] = ".*"/dst_ip[16] = "'$PS4IP'"/' ${PS4DEV}/ps4link/ps4sh/src/ps4sh.c && \
    make && \
    cd .. && \
    cd samples/sample && \
    make && \
    cp bin/*.elf ${PS4DEV}/ps4link/ps4sh/bin

#RUN \
#    cd ${PS4DEV} && \
#    git clone https://github.com/ps4dev/elf-loader && \
#    cd elf-loader && \
#    make clean && make

#WORKDIR ${PS4DEV}/ps4link/ps4sh/bin
CMD /bin/bash
#CMD /usr/bin/tmux
#CMD node server.js


WORKDIR /build

#CMD node ${PS4DEV}/elf-loader/local/server.js
