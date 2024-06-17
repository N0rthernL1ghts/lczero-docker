ARG LCZERO_VERSION=0.29
FROM --platform=${TARGETPLATFORM} alpine:3.18 AS lczero-build

ARG LCZERO_VERSION
ARG LCZERO_REPOSITORY=https://github.com/LeelaChessZero/lc0.git

WORKDIR /tmp

ADD ["https://bootstrap.pypa.io/get-pip.py", "/tmp/get-pip.py"]
COPY ["./patches/${LCZERO_VERSION}/meson.build.patch", "/tmp/meson.build.patch"]

RUN set -eux \
    && apk add git alpine-sdk bash ninja openblas-dev protoc protobuf-dev cmake gcompat gtest-dev python3 \
    && if [ "$(uname -m)" = "x86_64" ]; then \
           apk add eigen-dev; \
       fi \
    && git clone -b "release/${LCZERO_VERSION}" --jobs="$(nproc)" --depth=1 --recurse-submodules "${LCZERO_REPOSITORY}" lczero \
    && rm -rf /usr/lib/python*/EXTERNALLY-MANAGED \
    && python3 /tmp/get-pip.py \
    && pip install meson \
    && cd lczero \
    && patch --verbose "meson.build" <"/tmp/meson.build.patch" \
    && CXXFLAGS=-U_FORTIFY_SOURCE ./build.sh



FROM scratch AS rootfs

COPY ["./rootfs", "/"]
COPY --from=lczero-build ["/tmp/lczero/build/release/lc0", "/lczero/"]
COPY --from=hairyhenderson/gomplate:v3.11.5-alpine ["/bin/gomplate", "/usr/local/bin/"]
COPY --from=ghcr.io/n0rthernl1ghts/s6-rootfs:2.2 ["/", "/"]



FROM --platform=${TARGETPLATFORM} alpine:3.18

RUN set -eux \
    && apk add --update --no-cache libstdc++ ca-certificates curl netcat-openbsd openblas \
    && if [ "$(uname -m)" = "x86_64" ]; then \
           apk add eigen; \
       fi \
    && adduser --shell /bin/false --disabled-password --gecos "LCZero User" --home "/lczero" "lczero"

COPY --from=rootfs ["/", "/"]

LABEL maintainer="Aleksandar Puharic <aleksandar@puharic.com>" \
      org.opencontainers.image.source="https://github.com/N0rthernL1ghts/lczero-docker" \
      org.opencontainers.image.description="LcZero ${LCZERO_VERSION} (lc0) - Alpine Build ${TARGETPLATFORM}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.version="${LCZERO_VERSION}"

# s6-overlay configuration
ENV S6_KEEP_ENV=1
ENV S6_KILL_GRACETIME=6000
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=1

# LCZero
ARG LCZERO_VERSION
ENV LCZERO_VERSION="${LCZERO_VERSION}"
ENV LCZERO_NETWORK_SHA="d7c810f15aad363d58e8efc8d54e7c743191177db27017a441d695acd472c3c5"
ENV LCZERO_NETWORKS_PATH="/lczero/networks"
ENV LCZERO_NETWORK_GET_URI="https://training.lczero.org/get_network?sha="

WORKDIR /lczero

EXPOSE 3333/TCP

ENTRYPOINT ["/init"]
