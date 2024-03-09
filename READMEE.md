
# build u-boot via docker
https://source.denx.de/u-boot/u-boot/-/blob/master/doc/build/docker.rst
`sudo docker pull trini/u-boot-gitlab-ci-runner:bionic-20200807-02Sep2020`

## test signiture
https://github.com/ARM-software/u-boot/blob/master/doc/uImage.FIT/signature.txt
### rpi3-b-plus u-boot compile
https://github.com/mhomran/u-boot-rpi3-b-plus
### nice raspberry pi 3 initramfs tutorial
https://www.nayab.xyz/book/embedded-linux-rpi3-000-intro#learning-path
### signing u-boot build
https://community.nxp.com/t5/i-MX-Processors/iMX8-U-Boot-FIT-Image-Signature/td-p/1429547
### verify image signiture
`tools/fit_check_sign -f image.fit -k bcm2710-rpi-3-b-plus.dtb`
### securing u-boot
https://www.timesys.com/security/securing-u-boot-a-guide-to-mitigating-common-attack-vectors/
### rspi4 but nice info about initramfs
https://hechao.li/2021/12/20/Boot-Raspberry-Pi-4-Using-uboot-and-Initramfs/

# OPTEE setup
https://github.com/NVISOsecurity/VerifiedBootRPi3/blob/master/instructions.md


## build linux kernel with (not enabled by default)
- CONFIG_BLK_DEV_RAM
- BLK_DEV_INITRD
