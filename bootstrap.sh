#! /usr/bin/env bash
set -e


# Config
ZNC_VERSION="1.4"


# Ensure package list is up to date.
yum -y update

# Install runtime dependencies.
yum -y install sudo

# Install build dependencies.
yum -y install znc @development-tools openssl-devel perl-devel
#apt-get install -y wget build-essential libssl-dev libperl-dev pkg-config


# Prepare building
# mkdir -p /src


# # Download, compile and install ZNC.
# cd /src
# wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz"
# tar -zxf "znc-${ZNC_VERSION}.tar.gz"
# cd "znc-${ZNC_VERSION}"
# ./configure && make && make install


# # Clean up
# apt-get remove -y wget
# apt-get autoremove -y
# apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

yum -y clean all