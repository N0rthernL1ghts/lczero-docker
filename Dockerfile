# LCZero Build
FROM debian:stable-slim AS lczero-build

ARG LCZERO_REPOSITORY=https://github.com/LeelaChessZero/lc0.git
ARG LCZERO_VERSION=0.22

WORKDIR /tmp

RUN set -eux \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install --yes  --no-install-recommends \
            build-essential \
            git \
            libopenblas-dev \
            ninja-build \
            python3 \
            python3-setuptools \
            python3-pip \
            python \
            libgtest-dev \
            cmake \
            protobuf-compiler \
            libprotobuf-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && pip3 install meson \
    && git clone -b "release/${LCZERO_VERSION}" --depth=1 --recurse-submodules "${LCZERO_REPOSITORY}" lczero \
    && cd  lczero \
    && ./build.sh \
    && rm lczero/build/release/{*@exe,*.ninja,meson-*,compile_*,*_test} -rf

# LCZero Service
FROM nlss/xinetd:debian AS lczero-service

RUN set -eux \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install libprotobuf-dev libopenblas-dev --yes --no-install-recommends \
    && adduser --shell /bin/false --disabled-password --gecos "LCZero User" --home "/lczero" "lczero" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && echo "lczero          3333/tcp                        # LCZero" >> "/etc/services"

ADD rootfs /
COPY --from=lczero-build /tmp/lczero/build/release /lczero/bin

VOLUME ["/lczero/resources"]

EXPOSE 3333/TCP