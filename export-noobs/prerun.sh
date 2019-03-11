***REMOVED***

IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"
NOOBS_DIR="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***"
unmount_image "${IMG_FILE***REMOVED***"

mkdir -p "${STAGE_WORK_DIR***REMOVED***"
cp "${WORK_DIR***REMOVED***/export-image/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img" "${STAGE_WORK_DIR***REMOVED***/"

rm -rf "${NOOBS_DIR***REMOVED***"

PARTED_OUT=$(parted -s "${IMG_FILE***REMOVED***" unit b print)
BOOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^ 1'| xargs echo -n \
| cut -d" " -f 2 | tr -d B)
BOOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^ 1'| xargs echo -n \
| cut -d" " -f 4 | tr -d B)

ROOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
| cut -d" " -f 2 | tr -d B)
ROOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
| cut -d" " -f 4 | tr -d B)

BOOT_DEV=$(losetup --show -f -o "${BOOT_OFFSET***REMOVED***" --sizelimit "${BOOT_LENGTH***REMOVED***" "${IMG_FILE***REMOVED***")
ROOT_DEV=$(losetup --show -f -o "${ROOT_OFFSET***REMOVED***" --sizelimit "${ROOT_LENGTH***REMOVED***" "${IMG_FILE***REMOVED***")
echo "/boot: offset $BOOT_OFFSET, length $BOOT_LENGTH"
echo "/:     offset $ROOT_OFFSET, length $ROOT_LENGTH"

mkdir -p "${STAGE_WORK_DIR***REMOVED***/rootfs"
mkdir -p "${NOOBS_DIR***REMOVED***"

mount "$ROOT_DEV" "${STAGE_WORK_DIR***REMOVED***/rootfs"
mount "$BOOT_DEV" "${STAGE_WORK_DIR***REMOVED***/rootfs/boot"

ln -sv "/lib/systemd/system/apply_noobs_os_config.service" "$ROOTFS_DIR/etc/systemd/system/multi-user.target.wants/apply_noobs_os_config.service"

bsdtar --numeric-owner --format gnutar -C "${STAGE_WORK_DIR***REMOVED***/rootfs/boot" -cpf - . | xz -T0 > "${NOOBS_DIR***REMOVED***/boot.tar.xz"
umount "${STAGE_WORK_DIR***REMOVED***/rootfs/boot"
bsdtar --numeric-owner --format gnutar -C "${STAGE_WORK_DIR***REMOVED***/rootfs" --one-file-system -cpf - . | xz -T0 > "${NOOBS_DIR***REMOVED***/root.tar.xz"

unmount_image "${IMG_FILE***REMOVED***"
