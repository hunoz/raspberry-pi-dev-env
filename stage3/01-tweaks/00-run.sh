***REMOVED***

on_chroot sh -e - <<***REMOVED***
update-alternatives --install /usr/share/images/desktop-base/desktop-background \
desktop-background /usr/share/raspberrypi-artwork/raspberry-pi-logo.png 100
***REMOVED***

rm -f ${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d/wait.conf
