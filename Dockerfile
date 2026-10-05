FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

#
# Base packages
#

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    wget \
    gnupg \
    git \
    build-essential \
    cmake \
    pkg-config \
    python3 \
    python3-pip \
    python3-dev \
    gdb \
    gdbserver \
    nano \
    vim \
    less \
    tree \
    file \
    strace \
    lsof \
    unzip \
    zip \
    ripgrep \
    binutils \
    bsdmainutils \
    util-linux \
    swig \
    patchelf \
    libssl-dev \
    liblz4-dev \
    libsnappy-dev \
    libsnappy1v5 \
    libzstd-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

#
# MongoDB 7
#

RUN curl -fsSL https://pgp.mongodb.com/server-7.0.asc \
    | gpg --dearmor -o /usr/share/keyrings/mongodb-server.gpg

RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" \
    > /etc/apt/sources.list.d/mongodb-org.list

RUN apt-get update && \
    apt-get install -y mongodb-org && \
    rm -rf /var/lib/apt/lists/*

#
# Python BSON tools
#

RUN pip3 install --no-cache-dir pymongo

#
# Standalone WiredTiger
#

WORKDIR /opt

RUN git clone https://github.com/wiredtiger/wiredtiger.git

WORKDIR /opt/wiredtiger

RUN mkdir build

WORKDIR /opt/wiredtiger/build

RUN cmake \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    ..

RUN make -j$(nproc)

RUN ln -sf /opt/wiredtiger/build/wt /usr/local/bin/wt

#
# Initialization
#

COPY init.sh /
COPY init.js /
COPY decode-bson.py /usr/local/bin/decode-bson

RUN chmod +x /init.sh /usr/local/bin/decode-bson

WORKDIR /data

VOLUME ["/data/db"]

EXPOSE 27017

CMD ["/bin/bash", "/init.sh"]