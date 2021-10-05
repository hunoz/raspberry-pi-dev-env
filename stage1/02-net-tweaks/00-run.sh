***REMOVED***

echo "${TARGET_HOSTNAME***REMOVED***" > "${ROOTFS_DIR***REMOVED***/etc/hostname"
echo "127.0.1.1		${TARGET_HOSTNAME***REMOVED***" >> "${ROOTFS_DIR***REMOVED***/etc/hosts"

on_chroot << ***REMOVED***
	SUDO_USER="${FIRST_USER_NAME***REMOVED***" raspi-config nonint do_net_names 1
***REMOVED***
