![https://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](https://www.linuxserver.io/) team brings you another quality container release featuring easy user mapping and community support. Be sure to checkout our [forums](https://forum.linuxserver.io/index.php) or for real-time support our [IRC](https://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/deluge

![](https://avatars2.githubusercontent.com/u/6733935?v=3&s=200)

[deluge](http://deluge-torrent.org/) Deluge is a lightweight, Free Software, cross-platform BitTorrent client.

* Full Encryption
* WebUI
* Plugin System
* Much more...

## Usage

```
docker create \
  --name deluge \
  --net=host \
  -e PUID=<UID> -e PGID=<GID> \
  -v </path/to/your/downloads>:/downloads \
  -v </path/to/deluge/config>:/config \
  -v /etc/localtime:/etc/localtime:ro \
  linuxserver/deluge
```

**Parameters**

* `--net=host` - Shares host networking with container, **required**.
* `-v /config` - deluge configs
* `-v /downloads` - torrent download directory
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it deluge /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

The admin interface is available at http://<ip>:8112 with a default user/password of admin/deluge.
To change the password (recommended) log in to the web interface and go to Preferences->Interface->Password.

## Info

* Monitor the logs of the container in realtime `docker logs -f deluge`.

## Versions
+ **01.07.16:** Rebase to alpine for smaller image size.
+ **09.11.15:** Add unrar and unzip
+ **15.10.15:** Initial Release. 
