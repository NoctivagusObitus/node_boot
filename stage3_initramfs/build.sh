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
}

compile_busybox() {
	docker run \
		--rm \
		--volume "${SCRIPT_HOME}/bin:${BUSYBOX_DIR}/bin" \
		--volume "${SCRIPT_HOME}/build_busybox.sh:${TOOLS_DIR}/build_busybox.sh" \
		--workdir ${BUSYBOX_DIR} \
		trini/u-boot-gitlab-ci-runner:${UBOOT_BUILD_IMAGE} \
		${TOOLS_DIR}/build_busybox.sh
}

check_tools
echo

compile_busybox
