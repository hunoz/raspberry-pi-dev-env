***REMOVED***

install -m 644 files/sources.list "${ROOTFS_DIR***REMOVED***/etc/apt/"
install -m 644 files/raspi.list "${ROOTFS_DIR***REMOVED***/etc/apt/sources.list.d/"

if [ -n "$APT_PROXY" ]; then
	install -m 644 files/51cache "${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache"
	sed "${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache" -i -e "s|APT_PROXY|${APT_PROXY***REMOVED***|"
else
	rm -f "${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache"
fi

on_chroot apt-key add - < files/raspberrypi.gpg.key
on_chroot << ***REMOVED***
apt-get update
apt-get dist-upgrade -y
***REMOVED***
