FROM lsiobase/alpine
MAINTAINER sparklyballs

# package version
ARG DELUGE_VER="1.3.13"

# environment settings
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install runtime packages
RUN \
 apk add --no-cache \
	librsvg \
	p7zip \
	py-pip \
	python \
	unrar \
	unzip \
	xdg-utils && \

 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	libtorrent-rasterbar

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	g++ \
	gcc \
	intltool \
	librsvg-dev \
	openssl-dev \
	py-gtk-dev \
	python-dev \
	tar && \

# install pip packages
 pip install --no-cache-dir -U \
	cffi \
	chardet \
	cryptography \
	enum \
	mako \
	pip \
	pyOpenSSL \
	pyxdg \
	service_identity \
	setuptools \
	six \
	twisted \
	zope.interface && \

# fetch and unpack deluge source
 mkdir -p \
	/tmp/deluge-src && \
 curl -o \
 /tmp/deluge.tar.bz2 -L \
	"http://download.deluge-torrent.org/source/deluge-${DELUGE_VER}.tar.bz2" && \
 tar xf /tmp/deluge.tar.bz2 -C \
	/tmp/deluge-src --strip-components=1 && \

# build and install package
 cd /tmp/deluge-src && \
 python setup.py build && \
 python setup.py install \
	--prefix=/usr --root=/ && \
 mkdir -p \
	/usr/lib/python2.7/site-packages/deluge/i18n && \
 mv /usr/lib/python2.7/site-packages/deluge/i18n/* \
	/usr/lib/python2.7/site-packages/deluge/i18n/ && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
