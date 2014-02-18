# Build environment for CyanogenMod
#
# VERSION               0.1

FROM ubuntu:12.04
MAINTAINER Michael Stucki <mundaun@gmx.ch>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -qq update
RUN apt-get install -y python-software-properties bsdmainutils curl screen

RUN add-apt-repository ppa:nilarimogard/webupd8
RUN apt-get update
RUN apt-get install -y android-tools-adb android-tools-fastboot

RUN apt-get install -y bison build-essential curl flex git-core gnupg gperf libesd0-dev libncurses5-dev libsdl1.2-dev libwxgtk2.8-dev libxml2 libxml2-utils lzop openjdk-6-jdk openjdk-6-jre pngcrush schedtool squashfs-tools xsltproc zip zlib1g-dev
RUN apt-get install -y g++-multilib gcc-multilib lib32ncurses5-dev lib32readline-gplv2-dev lib32z1-dev
RUN apt-get install -y tig

RUN useradd --create-home cmbuild

RUN mkdir /home/cmbuild/bin
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /home/cmbuild/bin/repo
RUN chmod a+x /home/cmbuild/bin/repo

RUN echo "export PATH=${PATH}:/home/cmbuild/bin" >> /etc/bash.bashrc
RUN echo "export USE_CCACHE=1" >> /etc/bash.bashrc

WORKDIR /home/cmbuild/android
VOLUME /home/cmbuild/android
