#!/bin/sh

# Fix console permissions as long as https://github.com/docker/docker/issues/9806 is not fixed
usermod --groups tty --append cmbuild
chgrp tty /dev/console
chmod g+rw /dev/console

su -c "cd /home/cmbuild/android; screen -s /bin/bash" cmbuild
