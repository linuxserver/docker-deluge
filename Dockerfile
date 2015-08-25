FROM linuxserver/baseimage
MAINTAINER Gonzalo Peci <weedv2@outlook.com>

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install Deluge
RUN add-apt-repository ppa:deluge-team/ppa > /dev/null && \
    apt-get update -q && \
    apt-get install -qy deluged deluge-web deluge-console && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Ports and Volumes
VOLUME /config
VOLUME /torrents
# expose port for http
EXPOSE 8112
# expose port for deluge daemon
EXPOSE 58846
# expose port for incoming torrent data (tcp and udp)
EXPOSE 58946
EXPOSE 58946/udp

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
