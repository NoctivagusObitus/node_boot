FROM trini/u-boot-gitlab-ci-runner:jammy-20240125-12Feb2024

ENV HOME=/home/uboot \
  ARCH=arm64 \
  CROSS_COMPILE=arm-linux-gnueabi-

USER root
RUN echo "update and install cross compiler" \
  && echo "install with recommends since busybox needs them" \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  gcc-arm-linux-gnueabi \
  && rm -r /var/lib/apt/lists/*

USER uboot
