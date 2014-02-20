#!/bin/sh

cd $(dirname $0)

SOURCE=$(pwd)/android
CONTAINER=cyanogenmod
REPOSITORY=stucki/cyanogenmod

# Create a shared folder which will be used as working directory.
test -d $SOURCE || mkdir $SOURCE

# Try to start an existing/stopped container with the given name $CONTAINER. Otherwise, run a new one.
docker start -i $CONTAINER 2>/dev/null || docker run -v $SOURCE:/home/cmbuild/android -i -t -name $CONTAINER $REPOSITORY sh -c "screen -s /bin/bash"

exit $?
