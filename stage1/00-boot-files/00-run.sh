***REMOVED***

mkdir -p "${ROOTFS_DIR***REMOVED***/boot/firmware"

if ! [ -L "${ROOTFS_DIR***REMOVED***/boot/overlays" ]; then
	ln -s firmware/overlays "${ROOTFS_DIR***REMOVED***/boot/overlays"
fi

install -m 644 files/cmdline.txt "${ROOTFS_DIR***REMOVED***/boot/firmware/"
if ! [ -L "${ROOTFS_DIR***REMOVED***/boot/cmdline.txt" ]; then
	ln -s firmware/cmdline.txt "${ROOTFS_DIR***REMOVED***/boot/cmdline.txt"
fi

install -m 644 files/config.txt "${ROOTFS_DIR***REMOVED***/boot/firmware/"
if ! [ -L "${ROOTFS_DIR***REMOVED***/boot/config.txt" ]; then
	ln -s firmware/config.txt "${ROOTFS_DIR***REMOVED***/boot/config.txt"
fi
