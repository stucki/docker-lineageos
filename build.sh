#!/bin/sh

cd $(dirname $0)

SOURCE=$(pwd)/android

test -d $SOURCE || mkdir $SOURCE

docker build -t stucki/cyanogenmod .

exit $?
