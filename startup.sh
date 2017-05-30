#!/bin/sh

# Initialize ccache if needed
if [ ! -f ${CCACHE_DIR}/ccache.conf ]; then
	echo "Initializing ccache in /srv/ccache..."
	ccache -M ${CCACHE_SIZE}
fi

export USER="build"

# Launch screen session
screen -s /bin/bash
