![](https://avatars2.githubusercontent.com/u/6733935?v=3&s=200)

# pecigonzalo/deluge

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
  -v </path/to/your/torrents>:/torrents \
  -v </path/to/deluge/config>:/config \
  -v /etc/localtime:/etc/localtime:ro \
  pecigonzalo/deluge
```

**Parameters**

* `--net=host` - Shares host networking with container, **required**.
* `-v /config` - deluge configs
* `-v /torrents` - torrent download directory
* `-e PGID` for for GroupID - see below for explanation
* `-e PUID` for for UserID - see below for explanation

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes this containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.  

## Updates / Monitoring

* Upgrade to the latest version of deluge simply `docker restart deluge`.
* Monitor the logs of the container in realtime `docker logs -f deluge`.

**Credits**

* pecigonzalo <weedv2@outlook.com>
* lonix <lonixx@gmail.com>
* [LinuxServer.io](http://linuxserver.io)