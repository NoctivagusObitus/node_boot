#!/bin/sh

INITRAMFS=$1

if [ ! -d "${INITRAMFS}" ]; then
	echo "'${INITRAMFS}' is not a directory -> something went wrong"
	exit 1
fi

mkdir --parents "${INITRAMFS}"/proc "${INITRAMFS}"/dev &&
	find "${INITRAMFS}" -print0 | cpio --null --create --verbose --format=newc | gzip --best >"${INITRAMFS}/initramfs.cpio.gz"
