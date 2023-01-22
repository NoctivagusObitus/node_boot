FROM initramfs:nocte

ENV FILES=${HOME}/files \
    FIT_IMAGE=${HOME}/image.fit \
    KEY_DIR=/home/uboot/key

COPY --chown=1000:1000 ./files/ ${FILES}/

RUN test -n "${UBOOT_DIR}" \
  && test -n "${TOOLS_DIR}" \
  && test -n "${KEY_DIR}" \
  && test -n "${INITRAMFS_DIR}" \
  && test "$(find "${FILES}" -name "*.dtb" | wc -l)" -eq "1" \
  && DTB_FILE="$(find "${FILES}" -name "*.dtb")" \
  && mkdir -pv "${KEY_DIR}" \
  && cd "${KEY_DIR}" \
  && openssl genpkey \
  -algorithm RSA \
  -out dev.key \
  -pkeyopt rsa_keygen_bits:2048 \
  -pkeyopt rsa_keygen_pubexp:65537 \
  && openssl req \
  -batch \
  -new \
  -x509 \
  -key "${KEY_DIR}"/dev.key \
  -out "${KEY_DIR}"/dev.crt \
  && cd ${FILES} \
  && mv -v ${INITRAMFS_DIR}/initramfs.cpio ${FILES}/ \
  && "${UBOOT_DIR}/tools/mkimage" -D "-I dts -O dtb -p 2000" -f "${FILES}/image.its" "${FIT_IMAGE}" \
  && "${UBOOT_DIR}/tools/mkimage" -D "-I dts -O dtb -p 2000" -F -k "${KEY_DIR}" -K "${DTB_FILE}" -r "${FIT_IMAGE}" \
  && exit 0 \
  || env \
  && echo "xxx" \
  && ls ${FILES} \
  && find "${FILES}" -name "*.dtb" \
  && exit 1
