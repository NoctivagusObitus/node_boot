#!/bin/sh

INITRAMFS=$1
TOOLS_DIR=/home/uboot/tools

if [ -z ${INITRAMFS} -o ! -d "${INITRAMFS}" ]; then
	echo "'${INITRAMFS}' is not a directory -> something went wrong"
	exit 1
fi

mkdir --parents "${INITRAMFS}"/proc "${INITRAMFS}"/dev &&
	cp -v ${TOOLS_DIR}/init ${INITRAMFS}/init
	find "${INITRAMFS}" -print0 | cpio --null --create --verbose --format=newc | gzip --best >"${INITRAMFS}/initramfs.cpio.gz"
