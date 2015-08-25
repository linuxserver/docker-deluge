#!/bin/bash
apt-get update -qq
apt-get --only-upgrade install -y deluged
apt-get --only-upgrade install -y deluge-web
apt-get --only-upgrade install -y deluge-console
