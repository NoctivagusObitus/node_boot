#!/bin/bash

qemu-system-aarch64 \
  -machine virt -cpu cortex-a53 -m 4G -smp 4 \
  -bios ~/git/node_boot/build/output/u-boot.bin \
  -serial stdio
