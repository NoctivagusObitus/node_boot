FROM busybox:nocte

COPY --chown=1000:1000 init ${INITRAMFS_DIR}/init

RUN chmod +x ${INITRAMFS_DIR}/init \
  && mkdir --parents \
  "${INITRAMFS_DIR}"/proc \
  "${INITRAMFS_DIR}"/dev \
  && echo "create rpi3 device nodes" \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/tty c 5 0 \
  && sudo mknod -m 666 ${INITRAMFS_DIR}/dev/console c 5 1 \
  && sudo chown root:tty \
  ${INITRAMFS_DIR}/dev/console \
  ${INITRAMFS_DIR}/dev/tty \
  && ln -sf /dev/null ${INITRAMFS_DIR}/dev/tty2 \
  && ln -sf /dev/null ${INITRAMFS_DIR}/dev/tty3 \
  && ln -sf /dev/null ${INITRAMFS_DIR}/dev/tty4 \
  && echo "package initramfs" \
  && cd "${INITRAMFS_DIR}" \
  && find . -print0 | cpio --null --create --verbose --format=newc >"${INITRAMFS_DIR}/initramfs.cpio"
