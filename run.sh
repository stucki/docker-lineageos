#!/bin/sh

cd $(dirname $0)

SOURCE=$(pwd)/android

test -d $SOURCE || mkdir $SOURCE

docker run -v $SOURCE:/home/cmbuild/android -i -t stucki/cyanogenmod sh -c "exec >/dev/tty 2>/dev/tty </dev/tty && /bin/bash"

exit $?
