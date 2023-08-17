***REMOVED***

NOOBS_DIR="${STAGE_WORK_DIR***REMOVED***/${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***"
mkdir -p "${STAGE_WORK_DIR***REMOVED***"

IMG_FILE="${WORK_DIR***REMOVED***/export-image/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"

unmount_image "${IMG_FILE***REMOVED***"

rm -rf "${NOOBS_DIR***REMOVED***"

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

mkdir -p "${STAGE_WORK_DIR***REMOVED***/rootfs"
mkdir -p "${NOOBS_DIR***REMOVED***"

mount "$ROOT_DEV" "${STAGE_WORK_DIR***REMOVED***/rootfs"
mount "$BOOT_DEV" "${STAGE_WORK_DIR***REMOVED***/rootfs/boot"

ln -sv "/lib/systemd/system/apply_noobs_os_config.service" "$ROOTFS_DIR/etc/systemd/system/multi-user.target.wants/apply_noobs_os_config.service"

KERNEL_VER="$(zgrep -oPm 1 "Linux version \K(.*)$" "${STAGE_WORK_DIR***REMOVED***/rootfs/usr/share/doc/raspberrypi-kernel/changelog.Debian.gz" | cut -f-2 -d.)"
echo "$KERNEL_VER" > "${STAGE_WORK_DIR***REMOVED***/kernel_version"

bsdtar --numeric-owner --format gnutar -C "${STAGE_WORK_DIR***REMOVED***/rootfs/boot" -cpf - . | xz -T0 > "${NOOBS_DIR***REMOVED***/boot.tar.xz"
umount "${STAGE_WORK_DIR***REMOVED***/rootfs/boot"
bsdtar --numeric-owner --format gnutar -C "${STAGE_WORK_DIR***REMOVED***/rootfs" --one-file-system -cpf - . | xz -T0 > "${NOOBS_DIR***REMOVED***/root.tar.xz"

if [ "${USE_QCOW2***REMOVED***" = "1" ]; then
	rm "$ROOTFS_DIR/etc/systemd/system/multi-user.target.wants/apply_noobs_os_config.service"
fi

unmount_image "${IMG_FILE***REMOVED***"
