#!/bin/sh

cd $(dirname $0)

SOURCE=$(pwd)/android
CONTAINER=cyanogenmod
REPOSITORY=stucki/cyanogenmod

test -d $SOURCE || mkdir $SOURCE

docker start -i $CONTAINER 2>/dev/null || docker run -v $SOURCE:/home/cmbuild/android -i -t -name $CONTAINER $REPOSITORY sh -c "exec >/dev/tty 2>/dev/tty </dev/tty && screen -s /bin/bash"

exit $?
