FROM lsiobase/alpine
MAINTAINER sparklyballs

# package version
ARG DELUGE_VER="1.3.13"

# environment settings
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install runtime packages
RUN \
 apk add --no-cache \
	curl \
	librsvg py-cffi \
	p7zip \
	py-chardet \
	py-cryptography \
	py-enum34 \
	py-gtk \
	py-mako \
	py-openssl \
	py-setuptools \
	py-six \
	py-twisted \
	tar \
	unrar \
	unzip \
	xdg-utils && \

 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	libtorrent-rasterbar \
	py-service_identity \
	py-xdg

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	intltool \
	librsvg-dev \
	py-gtk-dev && \

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
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
