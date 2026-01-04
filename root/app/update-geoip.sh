#!/usr/bin/with-contenv bash
# shellcheck shell=bash

# Sleep a random amount of time up to 3 hours so we're not hitting the server all at once
sleep $(( RANDOM % 10800 ))

# downlad latest GeoIP.dat
geoip_dat_path="/usr/share/GeoIP/GeoIP.dat"

if [[ -e "${geoip_dat_path}" ]]; then
    # Only update if the SHAs are different
    source_sha=$(sha1sum "${geoip_dat_path}" | awk '{print $1}')
    dest_sha=$(curl -s -L --retry 2 --retry-max-time 10 --retry-all-errors "https://geoip.linuxserver.io/dat_sha1.txt")

    if [[ "${source_sha}" != "${dest_sha}" ]]; then
        curl -s -L --retry 2 --retry-max-time 10 --retry-all-errors \
            "https://geoip.linuxserver.io/GeoIP.dat.gz" |
            gunzip > /tmp/GeoIP.dat && \
            mv /tmp/GeoIP.dat "${geoip_dat_path}" && \
            chmod 644 "${geoip_dat_path}"
    fi
fi
