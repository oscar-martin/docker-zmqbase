FROM ubuntu:14.04
MAINTAINER oscarmartinvicente@gmail.com

# Install needed packages
RUN apt-get update && apt-get install -y --fix-missing \
    curl \
    libtool \
    pkg-config \
    build-essential \
    autoconf \
    automake

ENV ZMQ_VERSION 4.1.4

# Install libzmq
RUN mkdir -p /tmp/zeromq \
    && curl -SL http://download.zeromq.org/zeromq-$ZMQ_VERSION.tar.gz | tar zxC /tmp/zeromq \
    && cd /tmp/zeromq/zeromq-$ZMQ_VERSION/ \
    && ./configure --without-libsodium \
    && make \
    && make install \
    && sudo ldconfig

# Clean up
RUN rm -rf /tmp/zeromq
RUN apt-get purge -y libtool \
    pkg-config \
    build-essential \
    autoconf \
    automake
RUN apt-get clean && apt-get autoclean && apt-get -y autoremove
