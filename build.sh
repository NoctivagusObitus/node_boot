#!/bin/sh

BUILD_HOME=$(pwd)

docker build -t node_boot_build docker &&
	cd ${BUILD_HOME}/stage2_u-boot/ &&
	./build.sh &&
	cd ${BUILD_HOME}/stage3_initramfs/ &&
	./build.sh
