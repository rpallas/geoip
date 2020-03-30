#!/usr/bin/env bash

export MAXMIND_KEY=5fJVNzndSwOFXD6V

echo "Getting latest Maxmind IP data"
curl "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=$MAXMIND_KEY&suffix=tar.gz" | tar -C . -xzv --wildcards '*/*.mmdb'

echo "Compress files in layer to zip file"
tar -zcvf geoip-data.zip --wildcards */*.mmdb

echo "Move zip to lambda layer"
mv geoip-data.zip src/geoIPDataLambdaLayer/nodejs/ipdata/geoip-data.zip

echo "Cleaning up unneeded files"
rm -r GeoLite2-*_*/
