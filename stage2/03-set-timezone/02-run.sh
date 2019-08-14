***REMOVED***

echo "${TIMEZONE_DEFAULT***REMOVED***" > "${ROOTFS_DIR***REMOVED***/etc/timezone"
rm "${ROOTFS_DIR***REMOVED***/etc/localtime"

on_chroot << ***REMOVED***
dpkg-reconfigure -f noninteractive tzdata
***REMOVED***
