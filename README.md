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

# [linuxserver/deluge](https://github.com/linuxserver/docker-deluge)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/deluge.svg)](https://microbadger.com/images/linuxserver/deluge "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/deluge.svg)](https://microbadger.com/images/linuxserver/deluge "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/deluge.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/deluge.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-deluge/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-deluge/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/deluge/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/deluge/latest/index.html)

[Deluge](http://deluge-torrent.org/) is a lightweight, Free Software, cross-platform BitTorrent client.

* Full Encryption
* WebUI
* Plugin System
* Much more...


[![deluge](https://avatars2.githubusercontent.com/u/6733935?v=3&s=200)](http://deluge-torrent.org/)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/deluge` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=deluge \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e UMASK_SET=<022> \
  -e TZ=<timezone> \
  -v </path/to/deluge/config>:/config \
  -v </path/to/your/downloads>:/downloads \
  --restart unless-stopped \
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
      - PUID=1000
      - PGID=1000
      - UMASK_SET=<022>
      - TZ=<timezone>
    volumes:
      - </path/to/deluge/config>:/config
      - </path/to/your/downloads>:/downloads
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `--net=host` | Shares host networking with container, **required**. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e UMASK_SET=<022>` | for umask setting of deluge, *optional* , default if left unset is 022. |
| `-e TZ=<timezone>` | Specify a timezone to use EG Europe/London |
| `-v /config` | deluge configs |
| `-v /downloads` | torrent download directory |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
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

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/deluge`
* Stop the running container: `docker stop deluge`
* Delete the container: `docker rm deluge`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start deluge`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull deluge`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d deluge`
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (especially useful if you don't remember the original parameters)
* Pull the latest image at its tag and replace it with the same env variables in one run:
  ```
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once deluge
  ```

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using Docker Compose.

* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic: 
```
git clone https://github.com/linuxserver/docker-deluge.git
cd docker-deluge
docker build \
  --no-cache \
  --pull \
  -t linuxserver/deluge:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`
```
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **09.06.19:** - Update to 2.x using deluge ppa.
* **02.05.19:** - Install full version of 7zip.
* **23.03.19:** - Switching to new Base images, shift to arm32v7 tag.
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
