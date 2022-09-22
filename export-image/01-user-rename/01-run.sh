***REMOVED***

if [[ "${DISABLE_FIRST_BOOT_USER_RENAME***REMOVED***" == "0" ]]; then
	on_chroot <<- ***REMOVED***
		SUDO_USER="${FIRST_USER_NAME***REMOVED***" rename-user -f -s
	***REMOVED***
else
	rm -f "${ROOTFS_DIR***REMOVED***/etc/xdg/autostart/piwiz.desktop"
fi
