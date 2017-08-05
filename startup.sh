#!/bin/sh

# Initialize ccache if needed
if [ ! -f ${CCACHE_DIR}/ccache.conf ]; then
	echo "Initializing ccache in /srv/ccache..."
	ccache -M ${CCACHE_SIZE}
fi

# in Docker, the USER variable is unset by default
# but some programs (like jack toolchain) rely on it
export USER="$(whoami)"

# Launch screen session
screen -s /bin/bash
