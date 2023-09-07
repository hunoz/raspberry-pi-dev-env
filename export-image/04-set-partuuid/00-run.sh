***REMOVED***

if [ "${NO_PRERUN_QCOW2***REMOVED***" = "0" ]; then

	IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"

	IMGID="$(dd if="${IMG_FILE***REMOVED***" skip=440 bs=1 count=4 2>/dev/null | xxd -e | cut -f 2 -d' ')"

	BOOT_PARTUUID="${IMGID***REMOVED***-01"
	ROOT_PARTUUID="${IMGID***REMOVED***-02"

	sed -i "s/BOOTDEV/PARTUUID=${BOOT_PARTUUID***REMOVED***/" "${ROOTFS_DIR***REMOVED***/etc/fstab"
	sed -i "s/ROOTDEV/PARTUUID=${ROOT_PARTUUID***REMOVED***/" "${ROOTFS_DIR***REMOVED***/etc/fstab"

	sed -i "s/ROOTDEV/PARTUUID=${ROOT_PARTUUID***REMOVED***/" "${ROOTFS_DIR***REMOVED***/boot/firmware/cmdline.txt"
fi

