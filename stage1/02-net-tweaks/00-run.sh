***REMOVED***

install -m 644 files/ipv6.conf ${ROOTFS_DIR***REMOVED***/etc/modprobe.d/ipv6.conf
install -m 644 files/hostname ${ROOTFS_DIR***REMOVED***/etc/hostname

ln -s /dev/null ${ROOTFS_DIR***REMOVED***/etc/systemd/network/99-default.link
