# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/unrar:latest as unrar

FROM ghcr.io/linuxserver/baseimage-alpine:edge

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DELUGE_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install software
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
    build-base && \
  echo "**** install packages ****" && \
  apk add --no-cache --upgrade --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    python3 \
    py3-future \
    py3-geoip \
    py3-requests \
    p7zip && \
  if [ -z ${DELUGE_VERSION+x} ]; then \
    DELUGE_VERSION=$(curl -sL "http://dl-cdn.alpinelinux.org/alpine/edge/community/x86_64/APKINDEX.tar.gz" | tar -xz -C /tmp \
    && awk '/^P:deluge$/,/V:/' /tmp/APKINDEX | sed -n 2p | sed 's/^V://'); \
  fi && \
  apk add -U --upgrade --no-cache \
    deluge==${DELUGE_VERSION} && \  
  echo "**** grab GeoIP database ****" && \
  curl -L --retry 10 --retry-max-time 60 --retry-all-errors \
    "https://mailfud.org/geoip-legacy/GeoIP.dat.gz" \
    | gunzip > /usr/share/GeoIP/GeoIP.dat && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    $HOME/.cache \
    /tmp/*

# add local files
COPY root/ /

# add unrar
COPY --from=unrar /usr/bin/unrar-alpine /usr/bin/unrar

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config
