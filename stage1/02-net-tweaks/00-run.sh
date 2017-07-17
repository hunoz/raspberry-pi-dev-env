***REMOVED***

install -m 644 files/ipv6.conf ${ROOTFS_DIR***REMOVED***/etc/modprobe.d/ipv6.conf
install -m 644 files/hostname ${ROOTFS_DIR***REMOVED***/etc/hostname

on_chroot << ***REMOVED***
dpkg-divert --add --local /lib/udev/rules.d/75-persistent-net-generator.rules
***REMOVED***
