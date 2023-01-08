#!/bin/sh

SCRIPT_DIR=$(pwd)
BUSYBOX_DIR=${SCRIPT_DIR}/busybox
BUSYBOX_TAG=1_35_0

export ARCH=arm64
export ROSS_COMPILE=arm-linux-gnueabi-

echo "install cross compiler" &&
	apt-get install -y \
		gcc-arm-linux-gnueabi \
		libncurses5-dev \
		install gawk &&
	echo "setup busybox build" &&
	git clone \
		--depth 1 \
		--branch ${BUSYBOX_TAG} \
		git://busybox.net/busybox.git \
		"${BUSYBOX_DIR}" &&
	cd "${BUSYBOX_DIR}" &&
	make defconfig &&
	echo "make busybox staticaly compiled for initramfs and set aarch64 crosscompiler" &&
	sed -i 's#.*CONFIG_STATIC.*#CONFIG_STATIC=y#g' .config &&
	make oldconfig &&
	echo "build busybox for $PLATFORM" &&
	make -j4
