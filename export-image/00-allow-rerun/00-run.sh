***REMOVED***

if [ ! -x "${ROOTFS_DIR***REMOVED***/usr/bin/qemu-arm-static" ]; then
	cp /usr/bin/qemu-arm-static "${ROOTFS_DIR***REMOVED***/usr/bin/"
fi

if [ -e "${ROOTFS_DIR***REMOVED***/etc/ld.so.preload" ]; then
	mv "${ROOTFS_DIR***REMOVED***/etc/ld.so.preload" "${ROOTFS_DIR***REMOVED***/etc/ld.so.preload.disabled"
fi
