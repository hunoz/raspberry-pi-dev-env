#!/bin/bash -e

mkdir -p "${ROOTFS_DIR}/root/"
sudo install -m 644 files/* "${ROOTFS_DIR}/root/"
sudo chmod +x "${ROOTFS_DIR}/root/usb.sh"
