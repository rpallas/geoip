#!/usr/bin/env bash

export MAXMIND_KEY=5fJVNzndSwOFXD6V

echo "Getting latest Maxmind IP data"
curl "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=$MAXMIND_KEY&suffix=tar.gz" | tar -C . -xzv --wildcards '*/*.mmdb'

echo "Move geoip data to lambda layer"
mv */*.mmdb src/geoIPDataLambdaLayer/nodejs/ipdata

echo
echo pwd `pwd`
echo pwd .. `pwd ..`
echo

echo "Compress files in layer to zip file"
tar -zcvf src/geoIPDataLambdaLayer.zip src/geoIPDataLambdaLayer

echo
echo ls: `ls -a`
echo ls src: `ls -a src`
echo ls .stackery: `ls -a .stackery`
echo ls .stackery/src: `ls -a .stackery/src`
echo

echo "Cleaning up unneeded files"
rm -r GeoLite2-*_*/
