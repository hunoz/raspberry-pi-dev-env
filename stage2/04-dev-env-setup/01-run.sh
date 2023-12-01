#!/bin/bash -e

source "$CONFIG_PATH"

if [ "$FIRST_USER_NAME" = "root" ]; then
  USER_HOME="/root"
else
  USER_HOME="/home/$FIRST_USER_NAME"
fi

mkdir -p "${ROOTFS_DIR}/sloop/"
sudo install -m 644 files/* "${ROOTFS_DIR}/sloop/"
sudo install -m 644 "${CONFIG_PATH}" "${ROOTFS_DIR}/sloop/config"
sudo chmod +x "${ROOTFS_DIR}/sloop/usb.sh"

sudo echo "USER_HOME=\"$USER_HOME\"" >> "${ROOTFS_DIR}/sloop/config"
