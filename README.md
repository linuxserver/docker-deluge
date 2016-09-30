[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/index.php/irc/
[podcasturl]: https://www.linuxserver.io/index.php/category/podcast/

[![linuxserver.io](https://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/deluge
[![](https://images.microbadger.com/badges/image/linuxserver/deluge.svg)](http://microbadger.com/images/linuxserver/deluge "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/deluge.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/deluge.svg)][hub][![Build Status](http://jenkins.linuxserver.io:8080/buildStatus/icon?job=Dockers/LinuxServer.io/linuxserver-deluge)](http://jenkins.linuxserver.io:8080/job/Dockers/job/LinuxServer.io/job/linuxserver-deluge/)
[hub]: https://hub.docker.com/r/linuxserver/deluge/

[deluge](http://deluge-torrent.org/) Deluge is a lightweight, Free Software, cross-platform BitTorrent client.

* Full Encryption
* WebUI
* Plugin System
* Much more...

[![deluge](https://avatars2.githubusercontent.com/u/6733935?v=3&s=200)][delugeurl]
[delugeurl]: http://deluge-torrent.org/

## Usage

```
docker create \
  --name deluge \
  --net=host \
  -e PUID=<UID> -e PGID=<GID> \
  -e TZ=<timezone> \
  -v </path/to/your/downloads>:/downloads \
  -v </path/to/deluge/config>:/config \
  linuxserver/deluge
```

**Parameters**

* `--net=host` - Shares host networking with container, **required**.
* `-v /config` - deluge configs
* `-v /downloads` - torrent download directory
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation
* `-e TZ` for timezone information, eg Europe/London

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it deluge /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application 

The admin interface is available at http://<ip>:8112 with a default user/password of admin/deluge.

To change the password (recommended) log in to the web interface and go to Preferences->Interface->Password.

Change the downloads location in the webui in Preferences->Downloads and use /downloads for completed downloads.

## Info

* Monitor the logs of the container in realtime `docker logs -f deluge`.

## Versions

+ **30.09.16:** Fix umask.
+ **09.09.16:** Add layer badges to README.
+ **30.08.16:** Use pip packages for some critical dependencies.
+ **28.08.16:** Add badges to README.
+ **15.08.16:** Rebase to alpine linux.
+ **09.11.15:** Add unrar and unzip
+ **15.10.15:** Initial Release. 
