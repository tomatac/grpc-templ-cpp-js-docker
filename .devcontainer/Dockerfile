# See the links below for container layers details (see Dockerfile, base.Dockerfile, library-scripts folder):
# https://github.com/microsoft/vscode-dev-containers/tree/v0.148.1/containers/cpp/.devcontainer/base.Dockerfile

# https://github.com/microsoft/vscode-dev-containers/tree/master/containers/ubuntu
# https://github.com/microsoft/vscode-dev-containers/blob/master/containers/ubuntu/.devcontainer/base.Dockerfile
# https://github.com/microsoft/vscode-dev-containers/blob/master/containers/ubuntu/.devcontainer/library-scripts/common-debian.sh

# https://github.com/microsoft/vscode-dev-containers/tree/master/containers/cpp
# https://github.com/microsoft/vscode-dev-containers/blob/master/containers/cpp/.devcontainer/base.Dockerfile

# [Choice] Debian / Ubuntu version: debian-10, debian-9, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="buster"
#ARG VARIANT="ubuntu-20.04"
FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-${VARIANT}

# Additional packages required by gRPC
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    build-essential autoconf libtool pkg-config  \
    libssl-dev \
    && apt-get clean

# Download and build an updated version of CMake
# https://github.com/Kitware/CMake/releases
WORKDIR /tmp/cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.19.1/cmake-3.19.1.tar.gz && \
    tar -xzvf cmake-3.19.1.tar.gz > /dev/null && \
    cd /tmp/cmake/cmake-3.19.1 && \
    ./bootstrap && \
    make -j8 && \
    make install && \
    rm -rf /tmp/cmake

# clone gRPC repo
ENV GRPC_RELEASE_TAG v1.33.2
ENV GRPC_SOURCE_DIR /git/grpc
WORKDIR /git
RUN git clone --recurse-submodules -b ${GRPC_RELEASE_TAG} https://github.com/grpc/grpc ${GRPC_SOURCE_DIR}

# build and install gRPC
RUN cd ${GRPC_SOURCE_DIR} && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DBUILD_DEPS=ON -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF ../.. && \
    make -j8 && \
    make install && \
    cd ${GRPC_SOURCE_DIR}

# build gRPC-web plugin  /  alternative use npm after installing node (npm install protoc-gen-grpc-web)
RUN git clone -b 1.2.1 https://github.com/grpc/grpc-web
# RUN cd /git/grpc-web/javascript/net/grpc/web && \
#     make -j8 && \
#     make install
RUN cd /git/grpc-web && \
    make plugin -j8 && \
    make install-plugin

# Install node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && \
    sudo apt-get update && \
    apt-get install -y nodejs && \
    apt-get clean

RUN npm install webpack-cli
RUN npm install webpack

