FROM ubuntu:18.04
MAINTAINER Naomi Peori <naomi@peori.ca>

ENV PS4DEV=/usr/local/ps4dev
ENV PS4SDK=$PS4DEV/ps4sdk
ENV LOCALIP=192.168.1.3
ENV PS4IP=192.168.1.5
ENV PS4SH=${PS4DEV}/ps4link/ps4sh/bin

RUN echo 'alias ps4sh="cd $PS4SH && ./ps4sh"' >> ~/.bashrc
RUN echo 'alias elfcp="cp bin/*.elf $PS4SH/homebrew.elf"' >> ~/.bashrc
RUN echo 'alias build="cd /build && make clean && make"' >> ~/.bashrc

RUN echo 'verbose = yes' >> ~/.ps4shrc
RUN echo 'debug = yes' >> ~/.ps4shrc

RUN \
    apt-get -y update && \
    apt-get -y install wget nano tmux build-essential clang curl git && \
    apt-get -y clean autoclean autoremove && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

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
    cd ps4sh && \
    sed -i -e 's/dst_ip\[16\] = ".*"/dst_ip[16] = "'$PS4IP'"/' ${PS4DEV}/ps4link/ps4sh/src/ps4sh.c && \
    make

RUN \
    cd ${PS4DEV} && \
    cd liborbis && \
    cd samples/starfield && \
    make && \
    cp bin/*.elf ${PS4SH}

RUN \
    wget -O - https://api.modarchive.org/downloads.php?moduleid=179048#estrayk_-_zweifeld.mod > ${PS4DEV}/ps4link/ps4sh/bin/zweifeld.mod

CMD /bin/bash

WORKDIR /build
