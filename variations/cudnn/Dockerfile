ARG PATCH_VERSION=0.29
ARG LCZERO_VERSION=0.29

# LCZero Build
FROM --platform=${TARGETPLATFORM} nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04 AS lczero-build

ARG LCZERO_REPOSITORY=https://github.com/LeelaChessZero/lc0.git
ARG LCZERO_VERSION
ARG PATCH_VERSION

WORKDIR /tmp

COPY ["./patches/${PATCH_VERSION}/meson.build.patch", "/tmp/meson.build.patch"]

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



# Adapt s6 rootfs for Ubuntu
FROM alpine AS s6-rootfs-fixed

COPY --from=ghcr.io/n0rthernl1ghts/s6-rootfs:2.2 ["/", "/tmp/s6-rootfs/"]

RUN apk add rsync \
    && rsync -ah --remove-source-files /tmp/s6-rootfs/bin/ /tmp/s6-rootfs/usr/bin/ \
    && rm /tmp/s6-rootfs/bin -rf

# Root filesystem builder
FROM scratch AS rootfs

COPY ["./rootfs", "/"]
COPY --from=lczero-build ["/tmp/lczero/build/release/lc0", "/lczero/"]
COPY --from=hairyhenderson/gomplate:v3.11.5-alpine ["/bin/gomplate", "/usr/local/bin/"]
COPY --from=s6-rootfs-fixed ["/tmp/s6-rootfs/", "/"]



# LCZero Service
FROM --platform=${TARGETPLATFORM} nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 AS lczero-service

RUN set -eux \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install ca-certificates curl netcat libopenblas-base --yes --no-install-recommends \
    && adduser --shell /bin/false --disabled-password --gecos "LCZero User" --home "/lczero" "lczero" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ /var/cache/* /var/log/*

COPY --from=rootfs ["/", "/"]

ARG LCZERO_VERSION
LABEL maintainer="Aleksandar Puharic <aleksandar@puharic.com>" \
      org.opencontainers.image.source="https://github.com/N0rthernL1ghts/lczero-docker" \
      org.opencontainers.image.description="LcZero ${LCZERO_VERSION} (lc0) - Ubuntu CUDNN Build ${TARGETPLATFORM}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.version="${LCZERO_VERSION}-ubuntu-cudnn"

# s6-overlay configuration
ENV S6_KEEP_ENV=1
ENV S6_KILL_GRACETIME=6000
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=1

# LCZero
ENV LCZERO_VERSION="${LCZERO_VERSION}"
ENV LCZERO_NETWORK_SHA="d7c810f15aad363d58e8efc8d54e7c743191177db27017a441d695acd472c3c5"
ENV LCZERO_NETWORKS_PATH="/lczero/networks"
ENV LCZERO_NETWORK_GET_URI="https://training.lczero.org/get_network?sha="
ENV LCZERO_BACKEND="cudnn-auto"

EXPOSE 3333/TCP

ENTRYPOINT ["/init"]
