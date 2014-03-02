#!/bin/sh

cd $(dirname $0)

SOURCE=$(pwd)/android

# Create a shared folder which will be used as working directory.
test -d $SOURCE || mkdir $SOURCE

docker build --no-cache --rm -t stucki/cyanogenmod .

exit $?
