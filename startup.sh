#!/bin/sh

# Initialize ccache if needed
if [ ! -f /srv/ccache/ccache.conf ]; then
	echo "Initializing ccache in /srv/ccache..."
	CCACHE_DIR=/srv/ccache ccache -M 50G
fi

export USER="build"

# Launch screen session
screen -s /bin/bash
