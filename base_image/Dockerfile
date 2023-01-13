FROM trini/u-boot-gitlab-ci-runner:jammy-20221130-11Jan2023

ENV HOME=/home/uboot \
  KEY_DIR=/home/uboot/key \
  ARCH=arm64 \
  CROSS_COMPILE=arm-linux-gnueabi-

USER root
RUN echo "update and install cross compiler" \
  && apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
  gcc-arm-linux-gnueabi \
  libncurses5-dev \
  gawk \
  && rm -r /var/lib/apt/lists/* \
  && mkdir -pv "${KEY_DIR}" \
  && chown -R 1000:1000 "${KEY_DIR}" \
  && echo "no RSA keys given -> generating new" \
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
  -out "${KEY_DIR}"/dev.crt

USER uboot
