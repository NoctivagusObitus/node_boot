#!/bin/sh

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

	if [ ! -d "${SCRIPT_HOME}/image" ]; then
		mkdir -pv "${SCRIPT_HOME}/image" &&
			chown -R 1000:1000 "${SCRIPT_HOME}/image"
	fi
}

compile_uboot() {
	docker run \
		--rm \
		--volume "${SCRIPT_HOME}/image:${UBOOT_DIR}/image" \
		--volume "${SCRIPT_HOME}/tools:${TOOLS_DIR}" \
		--workdir ${UBOOT_DIR} \
		node_boot_build \
		${TOOLS_DIR}/build_fit_image.sh
}

check_tools
echo

compile_uboot
