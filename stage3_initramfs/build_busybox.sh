#!/bin/sh

SCRIPT_DIR=$(pwd)
BUSYBOX_DIR=${SCRIPT_DIR}/busybox
BUSYBOX_TAG=1_35_0

export ARCH=arm64
export ROSS_COMPILE=arm-linux-gnueabi-

echo "install cross compiler" &&
	sudo apt-get update &&
	sudo apt-get upgrade -y &&
	sudo apt-get install -y \
		gcc-arm-linux-gnueabi \
		libncurses5-dev \
		gawk &&
	echo "setup busybox build" &&
	git clone \
		--depth 1 \
		--branch ${BUSYBOX_TAG} \
		git://busybox.net/busybox.git \
		"${BUSYBOX_DIR}" &&
	cd "${BUSYBOX_DIR}" &&
	make oldconfig &&
	make defconfig &&
	echo "make busybox staticaly compiled for initramfs" &&
	sed -i 's#.*CONFIG_STATIC.*#CONFIG_STATIC=y#g' .config &&
	echo "build busybox" &&
	make -j4 &&
	cp -v busybox "${SCRIPT_DIR}/bin/"
