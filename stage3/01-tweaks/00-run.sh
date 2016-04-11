***REMOVED***

on_chroot sh -e - <<***REMOVED***
update-alternatives --set libgksu-gconf-defaults /usr/share/libgksu/debian/gconf-defaults.libgksu-sudo
update-gconf-defaults
***REMOVED***

on_chroot sh -e - <<***REMOVED***
update-alternatives --install /usr/share/images/desktop-base/desktop-background \
desktop-background /usr/share/raspberrypi-artwork/raspberry-pi-logo.png 100
***REMOVED***

rm -f							${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d/wait.conf
install -m 644 files/55-storage.pkla			${ROOTFS_DIR***REMOVED***/etc/polkit-1/localauthority/50-local.d/
install -m 644 files/75source-profile		${ROOTFS_DIR***REMOVED***/etc/X11/Xsession.d/
