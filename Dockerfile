FROM lsiobase/alpine
MAINTAINER Gonzalo Peci <davyjones@linuxserver.io>, sparklyballs

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install runtime packages
RUN \
 apk add --no-cache \
	p7zip \
	python \
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
	openssl-dev \
	py-pip \
	python-dev && \

# install pip packages
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
