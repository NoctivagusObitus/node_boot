#!/bin/sh

UBOOT_BUILD_IMAGE=jammy-20221101-22Nov2022 # https://hub.docker.com/r/trini/u-boot-gitlab-ci-runner/tags

SCRIPT_HOME=$(pwd)
BUSYBOX_DIR=/home/uboot
TOOLS_DIR=${BUSYBOX_DIR}/tools

check_tool() {
	"$@" 1>/dev/null 2>&1 || {
		echo "$@" "not working"
		exit 1
	}
	echo "'$1' seams to be installed"
}

check_tools() {
	check_tool docker --version

	if [ ! -d "${SCRIPT_HOME}/initramfs" ]; then
		echo "'${SCRIPT_HOME}/initramfs' is not a directory"
		echo "you want to manually creat it and set permissions "
		echo "so that inside docker files can be written by UID:GID of 1000:1000"
	fi
}

compile_busybox() {
	exec docker run \
		--rm \
		--volume "${SCRIPT_HOME}/initramfs:${BUSYBOX_DIR}/initramfs" \
		--volume "${SCRIPT_HOME}/tools/:${TOOLS_DIR}" \
		--workdir ${BUSYBOX_DIR} \
		--environment TOOLS_DIR=${TOOLS_dir} \
		trini/u-boot-gitlab-ci-runner:${UBOOT_BUILD_IMAGE} \
		${TOOLS_DIR}/build_busybox.sh
}

check_tools
echo

compile_busybox
