FROM busybox:nocte

COPY --chown=1000:1000 init ${INITRAMFS_DIR}/init

RUN chmod +x ${INITRAMFS_DIR}/init \
  && mkdir -p ${INITRAMFS_DIR}/dev/ \
  && echo "create rpi3 devce nodes" \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/tty c 5 0 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/tty2 c 5 0 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/tty3 c 5 0 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/tty4 c 5 0 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/null c 1 3 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/console c 5 1 \
  && sudo chown root:tty \
  ${INITRAMFS_DIR}/dev/tty \
  ${INITRAMFS_DIR}/dev/tty2 \
  ${INITRAMFS_DIR}/dev/tty3 \
  ${INITRAMFS_DIR}/dev/tty4 \
  ${INITRAMFS_DIR}/dev/console \
  && echo "package initramfs" \
  && cd "${INITRAMFS_DIR}" \
  && find . -print0 | cpio --null --create --verbose --format=newc >"${INITRAMFS_DIR}/initramfs.cpio.gz"
