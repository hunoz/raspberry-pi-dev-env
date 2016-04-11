***REMOVED***

ln -sf /etc/systemd/system/autologin@.service ${ROOTFS_DIR***REMOVED***/etc/systemd/system/getty.target.wants/getty@tty1.service

install -v -m 644 files/40-scratch.rules ${ROOTFS_DIR***REMOVED***/etc/udev/rules.d/
