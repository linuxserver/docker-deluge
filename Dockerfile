FROM linuxserver/baseimage
MAINTAINER Gonzalo Peci <davyjones@linuxserver.io>

#Add Deluge variable
ENV PYTHON_EGG_CACHE="/config/plugins/.python-eggs"

ENV APTLIST="deluged deluge-web deluge-console unrar unzip"

# Install Deluge
RUN add-apt-repository ppa:deluge-team/ppa > /dev/null && \
    apt-get update -q && \
    apt-get install $APTLIST -qy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Adding Custom files
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

#Ports and Volumes
VOLUME /config /downloads
EXPOSE 8112 58846 58946 58946/udp
