# The new base image to contain runtime dependencies
# source: https://www.jmoisio.eu/en/blog/2020/06/01/building-cpp-containers-using-docker-and-cmake/

FROM debian:buster AS base

RUN set -ex;         \
    apt-get update

# The first stage will install build dependencies on top of the
# runtime dependencies, and then compile

FROM base AS builder

RUN set -ex;                                                                      \
    apt-get install -y g++ curl cmake git; \
    mkdir -p /usr/src;                                                            \
    mkdir -p /usr/local/share


COPY . /usr/src/hello-cpp-docker

RUN set -ex;              \
    cd /usr/src/hello-cpp-docker;  \
    cmake -DCMAKE_BUILD_TYPE=Release .; make; make install

# The second stage will already contain all dependencies, just copy
# the compiled executables

FROM gcr.io/distroless/base-debian10

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/share /usr/local/share

EXPOSE 8080/tcp

ENTRYPOINT ["main"]
