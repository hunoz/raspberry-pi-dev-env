***REMOVED***

rm -f "${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache"
find "${ROOTFS_DIR***REMOVED***/var/lib/apt/lists/" -type f -delete
on_chroot << ***REMOVED***
apt-get update
apt-get -y dist-upgrade --auto-remove --purge
apt-get clean
***REMOVED***
