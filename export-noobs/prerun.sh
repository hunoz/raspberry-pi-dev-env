***REMOVED***

NOOBS_DIR="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***"
mkdir -p "${STAGE_WORK_DIR***REMOVED***"

if [ "${DEPLOY_ZIP***REMOVED***" == "1" ]; then
	IMG_FILE="${WORK_DIR***REMOVED***/export-image/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"
else
	IMG_FILE="${DEPLOY_DIR***REMOVED***/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"
fi

unmount_image "${IMG_FILE***REMOVED***"

rm -rf "${NOOBS_DIR***REMOVED***"

PARTED_OUT=$(parted -sm "${IMG_FILE***REMOVED***" unit b print)
BOOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^1:' | cut -d':' -f 2 | tr -d B)
BOOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^1:' | cut -d':' -f 4 | tr -d B)

ROOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^2:' | cut -d':' -f 2 | tr -d B)
ROOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^2:' | cut -d':' -f 4 | tr -d B)

echo "Mounting BOOT_DEV..."
cnt=0
until BOOT_DEV=$(losetup --show -f -o "${BOOT_OFFSET***REMOVED***" --sizelimit "${BOOT_LENGTH***REMOVED***" "${IMG_FILE***REMOVED***"); do
	if [ $cnt -lt 5 ]; then
		cnt=$((cnt + 1))
		echo "Error in losetup for BOOT_DEV.  Retrying..."
		sleep 5
	else
		echo "ERROR: losetup for BOOT_DEV failed; exiting"
		exit 1
	fi
done

echo "Mounting ROOT_DEV..."
cnt=0
until ROOT_DEV=$(losetup --show -f -o "${ROOT_OFFSET***REMOVED***" --sizelimit "${ROOT_LENGTH***REMOVED***" "${IMG_FILE***REMOVED***"); do
	if [ $cnt -lt 5 ]; then
		cnt=$((cnt + 1))
		echo "Error in losetup for ROOT_DEV.  Retrying..."
		sleep 5
	else
		echo "ERROR: losetup for ROOT_DEV failed; exiting"
		exit 1
	fi
done

echo "/boot: offset $BOOT_OFFSET, length $BOOT_LENGTH"
echo "/:     offset $ROOT_OFFSET, length $ROOT_LENGTH"

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
