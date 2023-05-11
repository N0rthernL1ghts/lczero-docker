# LCZero Build
FROM --platform=${TARGETPLATFORM} debian:11-slim AS lczero-build

ARG LCZERO_REPOSITORY=https://github.com/LeelaChessZero/lc0.git
ARG LCZERO_VERSION=0.28

WORKDIR /tmp

COPY ["./patches/${LCZERO_VERSION}/meson.build.patch", "/tmp/meson.build.patch"]

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
    && git clone -b "release/${LCZERO_VERSION}" --jobs="$(nproc)" --depth=1 --recurse-submodules "${LCZERO_REPOSITORY}" lczero \
    && cd  lczero \
    && patch --verbose "meson.build" <"/tmp/meson.build.patch" \
    && ./build.sh \
    && rm lczero/build/release/{*@exe,*.ninja,meson-*,compile_*,*_test} -rf



# Root filesystem builder
FROM scratch AS rootfs

COPY ["./rootfs", "/"]
COPY --from=lczero-build ["/tmp/lczero/build/release/lc0", "/lczero/bin/"]
COPY --from=hairyhenderson/gomplate:v3.11.5-alpine ["/bin/gomplate", "/usr/local/bin/"]
COPY --from=ghcr.io/n0rthernl1ghts/s6-rootfs:2.2 ["/", "/"]



# LCZero Service
FROM --platform=${TARGETPLATFORM} debian:11-slim AS lczero-service

RUN set -eux \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install ca-certificates curl netcat libopenblas-dev --yes --no-install-recommends \
    && adduser --shell /bin/false --disabled-password --gecos "LCZero User" --home "/lczero" "lczero" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ /var/cache/* /var/lib/dpkg/status /var/lib/dpkg/status-old /var/log/* \
    && echo "lczero          3333/tcp                        # LCZero" >> "/etc/services"

COPY --from=rootfs ["/", "/"]

ARG LCZERO_VERSION
LABEL maintainer="Aleksandar Puharic <aleksandar@puharic.com>" \
      org.opencontainers.image.source="https://github.com/N0rthernL1ghts/lczero-docker" \
      org.opencontainers.image.description="LcZero ${LCZERO_VERSION} (lc0) - Build ${TARGETPLATFORM}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.version="${LCZERO_VERSION}"

ENV LCZERO_VERSION="${LCZERO_VERSION}"
ENV LCZERO_NETWORK_SHA="d7c810f15aad363d58e8efc8d54e7c743191177db27017a441d695acd472c3c5"

EXPOSE 3333/TCP
