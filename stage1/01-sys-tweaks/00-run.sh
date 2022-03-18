***REMOVED***

install -d "${ROOTFS_DIR***REMOVED***/etc/systemd/system/getty@tty1.service.d"
install -m 644 files/noclear.conf "${ROOTFS_DIR***REMOVED***/etc/systemd/system/getty@tty1.service.d/noclear.conf"
install -v -m 644 files/fstab "${ROOTFS_DIR***REMOVED***/etc/fstab"

on_chroot << ***REMOVED***
if ! id -u ${FIRST_USER_NAME***REMOVED*** >/dev/null 2>&1; then
	adduser --disabled-password --gecos "" ${FIRST_USER_NAME***REMOVED***
fi

if [ -n "${FIRST_USER_PASS***REMOVED***" ]; then
	echo "${FIRST_USER_NAME***REMOVED***:${FIRST_USER_PASS***REMOVED***" | chpasswd
fi
echo "root:root" | chpasswd
***REMOVED***


