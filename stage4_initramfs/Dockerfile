FROM busybox:nocte

COPY --chown=1000:1000 init ${INITRAMFS_DIR}/init

RUN chmod +x ${INITRAMFS_DIR}/init \
  && mkdir -p ${INITRAMFS_DIR}/dev/ \
  && echo "create rpi3 devce nodes" \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/tty c 5 0 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/null c 1 3 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/console c 5 1 \
  && chown root:tty ${INITRAMFS_DIR}/{tty,console} \
  && echo "package initramfs" \
  && cd "${INITRAMFS_DIR}" \
  && find . -print0 | cpio --null --create --verbose --format=newc >"${INITRAMFS_DIR}/initramfs.cpio.gz"
