FROM busybox:nocte

COPY --chown=1000:1000 init ${INITRAMFS_DIR}/init

RUN chmod +x ${INITRAMFS_DIR}/init \
  && mkdir -p ${INITRAMFS_DIR}/dev/ \
  && sudo cp --archive /dev/{null,console,tty} ${INITRAMFS_DIR}/dev/ \
  && cd "${INITRAMFS_DIR}" \
  && find . -print0 | cpio --null --create --verbose --format=newc >"${INITRAMFS_DIR}/initramfs.cpio.gz"
