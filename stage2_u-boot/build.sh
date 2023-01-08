#!/bin/sh

UBOOT_BUILD_IMAGE=jammy-20221101-22Nov2022 # https://hub.docker.com/r/trini/u-boot-gitlab-ci-runner/tags

SCRIPT_HOME=$(pwd)
UBOOT_DIR=/home/uboot
TOOLS_DIR=${UBOOT_DIR}/tools

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

compile_uboot() {
	docker run \
		--rm \
		--volume "${SCRIPT_HOME}/image:${UBOOT_DIR}/image" \
		--volume "${SCRIPT_HOME}/tools:${TOOLS_DIR}" \
		--workdir ${UBOOT_DIR} \
		trini/u-boot-gitlab-ci-runner:${UBOOT_BUILD_IMAGE} \
		${TOOLS_DIR}/build_fit_image.sh
}

check_tools
echo

compile_uboot
