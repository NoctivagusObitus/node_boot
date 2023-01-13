#!/bin/sh

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

check_tool &&
	docker build -t base_image:nocte base_image &&
	docker build -t u-boot:nocte stage2_u-boot &&
	docker build -t busybox:nocte stage3_busybox &&
	docker build -t initramfs:nocte stage4_initramfs &&
	docker build -t final:nocte final_image &&
	docker image prune --filter label=stage=builder
#cd "${BUILD_HOME}"/stage3_initramfs/ &&
#./build.sh &&
#echo "find DTB file in ${TOOLS_DIR}" &&
#if [ "$(find "${TOOLS_DIR}" -name "*.dtb" | wc -l)" -eq "1" ]; then
#	DTB_FILE="$(find "${TOOLS_DIR}" -name "*.dtb")"
#	export DTB_FILE
#else
#	echo "there has not been exactly one DTB file"
#	exit 1
#fi &&
#echo "find kernel file in ${TOOLS_DIR}" &&
#if [ "$(find "${TOOLS_DIR}" -name "*.img" | wc -l)" -eq "1" ]; then
#	KERNEL_FILE="$(find "${TOOLS_DIR}" -name "*.img")"
#	export KERNEL_FILE
#else
#	echo "there has not been exactly one kernel file"
#	exit 1
#fi
