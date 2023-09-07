***REMOVED***

install -m 644 files/sources.list "${ROOTFS_DIR***REMOVED***/etc/apt/"
install -m 644 files/raspi.list "${ROOTFS_DIR***REMOVED***/etc/apt/sources.list.d/"
sed -i "s/RELEASE/${RELEASE***REMOVED***/g" "${ROOTFS_DIR***REMOVED***/etc/apt/sources.list"
sed -i "s/RELEASE/${RELEASE***REMOVED***/g" "${ROOTFS_DIR***REMOVED***/etc/apt/sources.list.d/raspi.list"

if [ -n "$APT_PROXY" ]; then
	install -m 644 files/51cache "${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache"
	sed "${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache" -i -e "s|APT_PROXY|${APT_PROXY***REMOVED***|"
else
	rm -f "${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache"
fi

cat files/raspberrypi.gpg.key | gpg --dearmor > "${STAGE_WORK_DIR***REMOVED***/raspberrypi-archive-stable.gpg"
install -m 644 "${STAGE_WORK_DIR***REMOVED***/raspberrypi-archive-stable.gpg" "${ROOTFS_DIR***REMOVED***/etc/apt/trusted.gpg.d/"
on_chroot << ***REMOVED***
dpkg --add-architecture arm64
apt-get update
apt-get dist-upgrade -y
***REMOVED***
