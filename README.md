[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# PSA: Changes are happening

From August 2018 onwards, Linuxserver are in the midst of switching to a new CI platform which will enable us to build and release multiple architectures under a single repo. To this end, existing images for `arm64` and `armhf` builds are being deprecated. They are replaced by a manifest file in each container which automatically pulls the correct image for your architecture. You'll also be able to pull based on a specific architecture tag.

TLDR: Multi-arch support is changing from multiple repos to one repo per container image.

# [linuxserver/deluge](https://github.com/linuxserver/docker-deluge)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/deluge.svg)](https://microbadger.com/images/linuxserver/deluge "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/deluge.svg)](https://microbadger.com/images/linuxserver/deluge "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/deluge.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/deluge.svg)

[Deluge](http://deluge-torrent.org/) is a lightweight, Free Software, cross-platform BitTorrent client.

* Full Encryption
* WebUI
* Plugin System
* Much more...


[![deluge](https://avatars2.githubusercontent.com/u/6733935?v=3&s=200)](http://deluge-torrent.org/)

## Supported Architectures

Our images support multiple architectures such as `X86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list). 

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| X86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |

## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=deluge \
  --net=host \
  -e PUID=1001 \
  -e PGID=1001 \
  -e UMASK_SET=<022> \
  -e TZ=<timezone> \
  -v </path/to/deluge/config>:/config \
  -v </path/to/your/downloads>:/downloads \
  --restart unless-stopped
  linuxserver/deluge
```


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  deluge:
    image: linuxserver/deluge
    container_name: deluge
    network_mode: host
    environment:
      - PUID=1001
      - PGID=1001
      - UMASK_SET=<022>
      - TZ=<timezone>
    volumes:
      - </path/to/deluge/config>:/config
      - </path/to/your/downloads>:/downloads
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `--net=host` | Shares host networking with container, **required**. |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e UMASK_SET=<022>` | for umask setting of deluge, *optional* , default if left unset is 022. |
| `-e TZ=<timezone>` | Specify a timezone to use EG Europe/London |
| `-v /config` | deluge configs |
| `-v /downloads` | torrent download directory |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

&nbsp;
## Application Setup

The admin interface is available at http://<ip>:8112 with a default user/password of admin/deluge.

To change the password (recommended) log in to the web interface and go to Preferences->Interface->Password.

Change the downloads location in the webui in Preferences->Downloads and use /downloads for completed downloads.



## Support Info

* Shell access whilst the container is running: `docker exec -it deluge /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f deluge`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' deluge`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/deluge`

## Versions

* **15.11.18:** - Add deluge-console.
* **11.11.18:** - Rebase to Ubuntu Bionic, add pipeline multiarch logic.
* **09.04.18:** - update to libressl2.7-libssl.
* **29.03.18:** - Rebase to alpine edge.
* **07.12.17:** - Rebase to alpine 3.7.
* **20.11.17:** - Change libressl2.6-libssl repo.
* **01.07.17:** - Add curl package.
* **26.05.17:** - Rebase to alpine 3.6.
* **29.04.17:** - Add variable for user defined umask.
* **28.04.17:** - update to libressl2.5-libssl.
* **28.12.16:** - Rebase to alpine 3.5 baseimage.
* **17.11.16:** - Rebase to edge baseimage.
* **13.10.16:** - Switch to libressl as openssl deprecated from alpine linux and deluge dependency no longer installs
* **30.09.16:** - Fix umask.
* **09.09.16:** - Add layer badges to README.
* **30.08.16:** - Use pip packages for some critical dependencies.
* **28.08.16:** - Add badges to README.
* **15.08.16:** - Rebase to alpine linux.
* **09.11.15:** - Add unrar and unzip
* **15.10.15:** - Initial Release.
