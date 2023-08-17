***REMOVED***

if [ "${NO_PRERUN_QCOW2***REMOVED***" = "0" ]; then
	IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"

	unmount_image "${IMG_FILE***REMOVED***"

	rm -f "${IMG_FILE***REMOVED***"

	rm -rf "${ROOTFS_DIR***REMOVED***"
	mkdir -p "${ROOTFS_DIR***REMOVED***"

	BOOT_SIZE="$((256 * 1024 * 1024))"
	ROOT_SIZE=$(du --apparent-size -s "${EXPORT_ROOTFS_DIR***REMOVED***" --exclude var/cache/apt/archives --exclude boot --block-size=1 | cut -f 1)

	# All partition sizes and starts will be aligned to this size
	ALIGN="$((4 * 1024 * 1024))"
	# Add this much space to the calculated file size. This allows for
	# some overhead (since actual space usage is usually rounded up to the
	# filesystem block size) and gives some free space on the resulting
	# image.
	ROOT_MARGIN="$(echo "($ROOT_SIZE * 0.2 + 200 * 1024 * 1024) / 1" | bc)"

	BOOT_PART_START=$((ALIGN))
	BOOT_PART_SIZE=$(((BOOT_SIZE + ALIGN - 1) / ALIGN * ALIGN))
	ROOT_PART_START=$((BOOT_PART_START + BOOT_PART_SIZE))
	ROOT_PART_SIZE=$(((ROOT_SIZE + ROOT_MARGIN + ALIGN  - 1) / ALIGN * ALIGN))
	IMG_SIZE=$((BOOT_PART_START + BOOT_PART_SIZE + ROOT_PART_SIZE))

	truncate -s "${IMG_SIZE***REMOVED***" "${IMG_FILE***REMOVED***"

	parted --script "${IMG_FILE***REMOVED***" mklabel msdos
	parted --script "${IMG_FILE***REMOVED***" unit B mkpart primary fat32 "${BOOT_PART_START***REMOVED***" "$((BOOT_PART_START + BOOT_PART_SIZE - 1))"
	parted --script "${IMG_FILE***REMOVED***" unit B mkpart primary ext4 "${ROOT_PART_START***REMOVED***" "$((ROOT_PART_START + ROOT_PART_SIZE - 1))"

	echo "Creating loop device..."
	cnt=0
	until ensure_next_loopdev && LOOP_DEV="$(losetup --show --find --partscan "$IMG_FILE")"; do
		if [ $cnt -lt 5 ]; then
			cnt=$((cnt + 1))
			echo "Error in losetup.  Retrying..."
			sleep 5
		else
			echo "ERROR: losetup failed; exiting"
			exit 1
		fi
	done

	BOOT_DEV="${LOOP_DEV***REMOVED***p1"
	ROOT_DEV="${LOOP_DEV***REMOVED***p2"

	ROOT_FEATURES="^huge_file"
	for FEATURE in 64bit; do
	if grep -q "$FEATURE" /etc/mke2fs.conf; then
		ROOT_FEATURES="^$FEATURE,$ROOT_FEATURES"
	fi
	done
	mkdosfs -n bootfs -F 32 -s 4 -v "$BOOT_DEV" > /dev/null
	mkfs.ext4 -L rootfs -O "$ROOT_FEATURES" "$ROOT_DEV" > /dev/null

	mount -v "$ROOT_DEV" "${ROOTFS_DIR***REMOVED***" -t ext4
	mkdir -p "${ROOTFS_DIR***REMOVED***/boot"
	mount -v "$BOOT_DEV" "${ROOTFS_DIR***REMOVED***/boot" -t vfat

	rsync -aHAXx --exclude /var/cache/apt/archives --exclude /boot "${EXPORT_ROOTFS_DIR***REMOVED***/" "${ROOTFS_DIR***REMOVED***/"
	rsync -rtx "${EXPORT_ROOTFS_DIR***REMOVED***/boot/" "${ROOTFS_DIR***REMOVED***/boot/"
fi
