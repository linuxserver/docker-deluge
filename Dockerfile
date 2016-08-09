FROM lsiobase/alpine
MAINTAINER Gonzalo Peci <davyjones@linuxserver.io>, sparklyballs

# environment variables
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

# install packages
RUN \
 apk add --no-cache \
	p7zip \
	unrar \
	unzip && \

 apk add --no-cache \
	--repository http://nl.alpinelinux.org/alpine/edge/testing \
	deluge \
	py-service_identity

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8112 58846 58946 58946/udp
VOLUME /config /downloads
