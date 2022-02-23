FROM ghcr.io/linuxserver/baseimage-alpine:3.15

ARG UNRAR_VERSION=6.1.4
# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install software
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --upgrade --virtual=build-dependencies \
    make \
    g++ \
    gcc \
    geoip-dev \
    python3-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    curl \
    deluge \
    geoip \
    py3-pip \
    python3 \
    p7zip \
    unzip && \
  echo "**** install unrar from source ****" && \
  mkdir /tmp/unrar && \
  curl -o \
    /tmp/unrar.tar.gz -L \
    "https://www.rarlab.com/rar/unrarsrc-${UNRAR_VERSION}.tar.gz" && \
  tar xf \
    /tmp/unrar.tar.gz -C \
    /tmp/unrar --strip-components=1 && \
  cd /tmp/unrar && \
  make && \
  install -v -m755 unrar /usr/local/bin && \
  echo "**** install python packages ****" && \
  pip3 install --no-cache-dir -U \
    pip && \
  pip install --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine/ \
    future \
    GeoIP \
    requests && \
  echo "**** grab GeoIP database ****" && \
  curl -o \
    /usr/share/GeoIP/GeoIP.dat -L \
    "https://ipfs.infura.io/ipfs/QmWTWcPRRbADZcLcJeANZmcJZNrcpmuQgKYBi6hGdddtC6" && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /root/.cache \
    /tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config
