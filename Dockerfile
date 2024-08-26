# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/unrar:latest AS unrar

FROM ghcr.io/by275/libtorrent:1-alpine3.20 AS libtorrent

FROM ghcr.io/linuxserver/baseimage-alpine:3.20

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DELUGE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs" \
  TMPDIR=/run/deluged-temp

# install software
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
    build-base \
    python3-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache --upgrade \
    boost1.84-python3 \
    geoip \
    python3 \
    p7zip && \
  if [ -z ${DELUGE_VERSION+x} ]; then \
    DELUGE_VERSION=$(curl -sL  https://pypi.python.org/pypi/deluge/json |jq -r '. | .info.version');\
  fi && \
  python3 -m venv /lsiopy && \
  pip install -U --no-cache-dir \
    pip \
    setuptools \
    wheel && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.20/ \
    deluge[all]==${DELUGE_VERSION} \
    pygeoip && \
  echo "**** grab GeoIP database ****" && \
  curl -L --retry 10 --retry-max-time 60 --retry-all-errors \
    "https://mailfud.org/geoip-legacy/GeoIP.dat.gz" \
    | gunzip > /usr/share/GeoIP/GeoIP.dat && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    $HOME/.cache \
    /tmp/*

  COPY --from=libtorrent /libtorrent-build/usr/lib/libtorrent-rasterbar.* /usr/lib/

  COPY --from=libtorrent /libtorrent-build/usr/lib/python3.12 /lsiopy/lib/python3.12

# add local files
COPY root/ /

# add unrar
COPY --from=unrar /usr/bin/unrar-alpine /usr/bin/unrar

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config
