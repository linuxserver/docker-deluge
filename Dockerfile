FROM lsiobase/alpine:3.5
MAINTAINER Gonzalo Peci <davyjones@linuxserver.io>, sparklyballs

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install runtime packages
RUN \
 apk add --no-cache \
	ca-certificates \
	libressl2.4-libssl \
	p7zip \
	unrar \
	unzip && \
 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	deluge && \

# install build packages
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	libffi-dev \
	libressl-dev \
	py2-pip \
	python2-dev && \

# install pip packages
 pip install --no-cache-dir -U \
	incremental \
	pip && \
 pip install --no-cache-dir -U \
	crypto \
	mako \
	markupsafe \
	pyopenssl \
	service_identity \
	six \
	twisted \
	zope.interface && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
