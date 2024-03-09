FROM busybox:nocte

RUN mkdir -pv \
  "${INITRAMFS_DIR}"/proc \
  "${INITRAMFS_DIR}"/dev \
  "${INITRAMFS_DIR}"/etc \
  && echo "create rpi3 device nodes" \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/null c 1 3 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/tty c 5 0 \
  && sudo mknod -m 622 ${INITRAMFS_DIR}/dev/console c 5 1 \
  && sudo chown root:tty \
  ${INITRAMFS_DIR}/dev/console \
  ${INITRAMFS_DIR}/dev/tty \
  && ln -sf /dev/null ${INITRAMFS_DIR}/dev/tty2 \
  && ln -sf /dev/null ${INITRAMFS_DIR}/dev/tty3 \
  && ln -sf /dev/null ${INITRAMFS_DIR}/dev/tty4 \
  && echo "package initramfs"

# https://git.busybox.net/busybox/plain/examples/udhcp/simple.script
COPY udhcpc_setup.sh ${INITRAMFS_DIR}/bin/udhcpc_setup.sh
COPY init ${INITRAMFS_DIR}/init

RUN cd "${INITRAMFS_DIR}" \
  && find . -print0 | cpio --null --create --verbose --format=newc >"${HOME}"/initramfs.cpio
# && find . | cpio --quiet -H newc -o | gzip -9 -n > "${INITRAMFS_DIR}/initramfs.cpio"
