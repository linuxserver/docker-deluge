FROM lsiobase/alpine
MAINTAINER Gonzalo Peci <davyjones@linuxserver.io>, sparklyballs

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install build dependencies
RUN \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	libffi-dev \
	openssl-dev \
	python-dev \
	py-pip && \

# install deluge
 apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/testing \
	deluge && \

# install pip packages
 pip install --no-cache-dir -U \
	service_identity && \

# uninstall build-dependencies
 apk del --purge \
	build-dependencies && \

# cleanup
 rm -rfv /var/cache/apk/* /root/.cache /tmp/*

# install runtime dependencies
RUN \
 apk add --no-cache \
	unrar \
	unzip

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 8112 58846 58946 58946/udp
