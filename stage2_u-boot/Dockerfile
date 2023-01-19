FROM base_image:nocte

ENV UBOOT_VERSION=v2023.01 \
  PLATFORM=rpi_3_b_plus \
  CROSS_COMPILE=/opt/gcc-12.2.0-nolibc/aarch64-linux/bin/aarch64-linux- \
  ARCH=arm64 \
  UBOOT_DIR=${HOME}/u-boot \
  TOOLS_DIR=${HOME}/tools

COPY oldconfig ${TOOLS_DIR}/oldconfig

RUN echo "setup u-boot build" \
  && echo "build: ${TOOLS_DIR}" \
  && git clone\
  --depth 1\
  --branch "${UBOOT_VERSION}"\
  https://source.denx.de/u-boot/u-boot.git\
  "${UBOOT_DIR}" \
  && cd "${UBOOT_DIR}" \
  && echo "setup u-boot for ${PLATFORM} build" \
  && make "${PLATFORM}"_defconfig \
  && cat "${TOOLS_DIR}/oldconfig" >>"${UBOOT_DIR}"/.config \
  && make olddefconfig \
  && echo "build u-boot for $PLATFORM" \
  && make -j "$(nproc)"
