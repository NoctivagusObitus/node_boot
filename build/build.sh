#!/bin/sh

FINAL_DIR=$(pwd)/output/

check_tool() {
  "$@" 1>/dev/null 2>&1 || {
    echo "$@" "not working"
    exit 1
  }
  echo "'$1' seams to be installed"
}

check_tools() {
  check_tool podman --version

  # if [ ! -d "${SCRIPT_HOME}/initramfs" ]; then
  #   mkdir -pv "${SCRIPT_HOME}/initramfs" &&
  #     chown -R 1000:1000 "${SCRIPT_HOME}/initramfs"
  # fi
}

check_tools &&
  echo "build 0" &&
  sudo podman build --dns 1.1.1.1 -t base_image:nocte base_image &&
  echo "build 1" &&
  sudo podman build --dns 1.1.1.1 -t u-boot:nocte stage2_u-boot &&
  echo "build 2" &&
  sudo podman build --dns 1.1.1.1 -t busybox:nocte stage3_busybox &&
  echo "build 3" &&
  sudo podman build --cap-add CAP_MKNOD -t initramfs:nocte stage4_initramfs &&
  echo "build 4" &&
  sudo podman build -t final:nocte final_image && {
  [ -d "${FINAL_DIR}" ] || mkdir -p "${FINAL_DIR}" &&
    sudo podman run --rm \
      -v "${FINAL_DIR}":/home/uboot/final/ \
      final:nocte \
      bash -c 'cp -v ${FIT_IMAGE} ${UBOOT_DIR}/u-boot.bin ${KEY_DIR}/* /home/uboot/final/'
}

#docker image prune --filter label=stage=builder &&

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
