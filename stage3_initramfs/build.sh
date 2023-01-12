#!/bin/sh

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
		mkdir -pv "${SCRIPT_HOME}/initramfs" &&
			chown -R 1000:1000 "${SCRIPT_HOME}/initramfs"
	fi
}

compile_busybox() {
	exec docker run \
		--rm \
		--volume "${SCRIPT_HOME}/initramfs:${BUSYBOX_DIR}/initramfs" \
		--volume "${SCRIPT_HOME}/tools/:${TOOLS_DIR}" \
		--workdir ${BUSYBOX_DIR} \
		--env TOOLS_DIR=${TOOLS_dir} \
		node_boot_build \
		${TOOLS_DIR}/build_busybox.sh
}

check_tools
echo

compile_busybox
