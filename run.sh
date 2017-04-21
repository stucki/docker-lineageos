#!/usr/bin/env bash

set -euo pipefail

cd $(dirname $0)

SOURCE=$(pwd)/android
CCACHE=$(pwd)/ccache
CONTAINER_HOME=/home/build
CONTAINER=lineageos
REPOSITORY=stucki/lineageos
TAG=cm-14.1
FORCE_BUILD=0
PRIVILEGED=

while [[ $# > 0 ]]; do
	key="$1"
	case $key in
		-r|--rebuild)
			FORCE_BUILD=1
			;;
		-u|--enable-usb)
			PRIVILEGED="--privileged -v /dev/bus/usb:/dev/bus/usb"
			;;
		*)
			shift # past argument or value
			;;
	esac
	shift
done

# Create shared folders
mkdir -p $SOURCE
mkdir -p $CCACHE

# Build image if needed
IMAGE_EXISTS=$(docker images $REPOSITORY)
if [ $? -ne 0 ]; then
	echo "docker command not found"
	exit $?
elif [[ $FORCE_BUILD = 1 ]] || ! echo "$IMAGE_EXISTS" | grep -q "$TAG"; then
	# Pull Ubuntu image to be sure it's up to date
	echo "Fetching Docker \"ubuntu\" image..."
	docker pull ubuntu:16.04

	echo "Building Docker image $REPOSITORY:$TAG..."
	USERID=$(id -u)
	GROUPID=$(id -g)
	docker build -t $REPOSITORY:$TAG --build-arg hostuid=$USERID --build-arg hostgid=$GROUPID .

	# After successful build, delete existing containers
	IS_EXISTING=$(docker inspect -f '{{.Id}}' $CONTAINER 2>/dev/null)
	if [[ -n $IS_EXISTING ]]; then
		docker rm $CONTAINER
	fi
fi

# With the given name $CONTAINER, reconnect to running container, start
# an existing/stopped container or run a new one if one does not exist.
IS_RUNNING=$(docker inspect -f '{{.State.Running}}' $CONTAINER 2>/dev/null)
if [[ $IS_RUNNING == "true" ]]; then
	docker attach $CONTAINER
elif [[ $IS_RUNNING == "false" ]]; then
	docker start -i $CONTAINER
else
	docker run $PRIVILEGED -v $SOURCE:$CONTAINER_HOME/android:Z -v $CCACHE:/srv/ccache:Z -i -t --name $CONTAINER $REPOSITORY:$TAG
fi

exit $?
