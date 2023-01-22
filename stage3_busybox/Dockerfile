FROM u-boot:nocte

ENV BUSYBOX_DIR=${HOME}/busybox \
  INITRAMFS_DIR=${HOME}/initramfs \
  BUSYBOX_TAG=1_35_0 \
  ARCH=arm64 \
  CROSS_COMPILE=arm-linux-gnueabi-

RUN mkdir -p ${INITRAMFS_DIR} \
  && echo "setup busybox build" \
  && git clone \
  --depth 1 \
  --branch ${BUSYBOX_TAG} \
  git://busybox.net/busybox.git \
  "${BUSYBOX_DIR}" \
  && cd "${BUSYBOX_DIR}" \
  && make defconfig \
  && echo "make busybox staticaly compiled for initramfs" \
  && sed -i 's#.*CONFIG_STATIC[^A-Z_0-9].*#CONFIG_STATIC=y#g' .config \
  && echo "build busybox" \
  && make -j "$(nproc)" \
  && make install \
  && echo "build initramfs" \
  && cp -r _install/* "${INITRAMFS_DIR}/"
