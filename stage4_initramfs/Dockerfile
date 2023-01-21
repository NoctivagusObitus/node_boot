FROM busybox:nocte

COPY --chown=1000:1000 init ${INITRAMFS_DIR}/init

RUN chmod +x ${INITRAMFS_DIR}/init \
  && cd "${INITRAMFS_DIR}" \
  && find . -print0 | cpio --null --create --verbose --format=newc >"${INITRAMFS_DIR}/initramfs.cpio.gz"
