#!/bin/sh

SCRIPT_DIR=$(pwd)
UBOOT_DIR="${SCRIPT_DIR}"/u-boot_tmp
TOOLS_DIR="${SCRIPT_DIR}"/tools
KEY_DIR="${TOOLS_DIR}"/keys
PLATFORM=rpi_3_b_plus
UBOOT_IMAGE=image.fit
UBOOT_VERSION=v2023.01-rc4

ARCH=arm64
export ARCH
CROSS_COMPILE=/opt/gcc-12.2.0-nolibc/aarch64-linux/bin/aarch64-linux-
export CROSS_COMPILE

sudo chown -R 1000:1000 "${SCRIPT_DIR}" &&
	echo "find DTB file in ${TOOLS_DIR}" &&
	if [ "$(find "${TOOLS_DIR}" -name "*.dtb" | wc -l)" -eq "1" ]; then
		DTB_FILE="$(find "${TOOLS_DIR}" -name "*.dtb")"
		export DTB_FILE
	else
		echo "there has not been exactly one DTB file"
		exit 1
	fi &&
	echo "find kernel file in ${TOOLS_DIR}" &&
	if [ "$(find "${TOOLS_DIR}" -name "*.img" | wc -l)" -eq "1" ]; then
		KERNEL_FILE="$(find "${TOOLS_DIR}" -name "*.img")"
		export KERNEL_FILE
	else
		echo "there has not been exactly one kernel file"
		exit 1
	fi &&
	if [ ! -f "${KEY_DIR}"/dev.key ]; then
		echo "no RSA keys given -> generating new" &&
			mkdir -pv "${KEY_DIR}" &&
			cd "${KEY_DIR}" &&
			openssl genpkey \
				-algorithm RSA \
				-out dev.key \
				-pkeyopt rsa_keygen_bits:2048 \
				-pkeyopt rsa_keygen_pubexp:65537 &&
			openssl req \
				-batch \
				-new \
				-x509 \
				-key "${KEY_DIR}"/dev.key \
				-out "${KEY_DIR}"/dev.crt
	fi &&
	git clone \
		--depth 1 \
		--branch "${UBOOT_VERSION}" \
		https://source.denx.de/u-boot/u-boot.git \
		"${UBOOT_DIR}" &&
	cd "${UBOOT_DIR}" &&
	echo "setup u-boot for ${PLATFORM} build" &&
	make "${PLATFORM}"_defconfig &&
	cat "${TOOLS_DIR}/oldconfig >> ${UBOOT_DIR}"/.config &&
	make olddefconfig &&
	echo "build u-boot for $PLATFORM" &&
	make -j "$(nproc)" &&
	echo "create and sign u-boot image" &&
	ln -s "${TOOLS_DIR}/${DTB_FILE}" "${UBOOT_DIR}" &&
	ln -s "${TOOLS_DIR}/${KERNEL_FILE}" "${UBOOT_DIR}" &&
	"${UBOOT_DIR}/tools/mkimage" -D "-I dts -O dtb -p 2000" -f "${TOOLS_DIR}/image.its" "${UBOOT_IMAGE}" &&
	"${UBOOT_DIR}/tools/mkimage" -D "-I dts -O dtb -p 2000" -F -k "${KEY_DIR}" -K "${DTB_FILE} -r ${UBOOT_IMAGE}" &&
	cp -v "${UBOOT_IMAGE}" "${UBOOT_DIR}/u-boot.bin" "${SCRIPT_DIR}/image/"
