#!/bin/sh

# Initialize ccache if needed
if [ ! -f /srv/ccache/CACHEDIR.TAG ]; then
	echo "Initializing ccache in /srv/ccache..."
	CCACHE_DIR=/srv/ccache ccache -M 50G
fi

# Fix permissions. This is needed temporarily to migrate old projects which were still checked out as root.
# It can be removed at some point in the future.
# For performance reasons, only search on the first level.
for i in "/home/cmbuild/android" "/srv/ccache"; do
	if [ $(find $i -maxdepth 1 -user root | wc -l) -gt 0 ]; then
		echo "Fixing permissions on $i..."
		chown -R cmbuild:cmbuild $i
	fi
done

# Launch screen session
screen -s /bin/bash
