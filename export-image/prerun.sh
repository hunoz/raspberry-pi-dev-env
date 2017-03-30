***REMOVED***
IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"

unmount_image ${IMG_FILE***REMOVED***

rm -f ${IMG_FILE***REMOVED***

rm -rf ${ROOTFS_DIR***REMOVED***
mkdir -p ${ROOTFS_DIR***REMOVED***

BOOT_SIZE=$(du -s ${EXPORT_ROOTFS_DIR***REMOVED***/boot --block-size=1 | cut -f 1)
TOTAL_SIZE=$(du -s ${EXPORT_ROOTFS_DIR***REMOVED*** --exclude var/cache/apt/archives --block-size=1 | cut -f 1)

IMG_SIZE=$((BOOT_SIZE + TOTAL_SIZE + (400 * 1024 * 1024)))

fallocate -l ${IMG_SIZE***REMOVED*** ${IMG_FILE***REMOVED***
fdisk -H 255 -S 63 ${IMG_FILE***REMOVED*** <<***REMOVED***
o
n


8192
+$((BOOT_SIZE * 2 /512))
p
t
c
n


8192


p
w
***REMOVED***

PARTED_OUT=$(parted -s ${IMG_FILE***REMOVED*** unit b print)
BOOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^ 1'| xargs echo -n \
| cut -d" " -f 2 | tr -d B)
BOOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^ 1'| xargs echo -n \
| cut -d" " -f 4 | tr -d B)

ROOT_OFFSET=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
| cut -d" " -f 2 | tr -d B)
ROOT_LENGTH=$(echo "$PARTED_OUT" | grep -e '^ 2'| xargs echo -n \
| cut -d" " -f 4 | tr -d B)

BOOT_DEV=$(losetup --show -f -o ${BOOT_OFFSET***REMOVED*** --sizelimit ${BOOT_LENGTH***REMOVED*** ${IMG_FILE***REMOVED***)
ROOT_DEV=$(losetup --show -f -o ${ROOT_OFFSET***REMOVED*** --sizelimit ${ROOT_LENGTH***REMOVED*** ${IMG_FILE***REMOVED***)
echo "/boot: offset $BOOT_OFFSET, length $BOOT_LENGTH"
echo "/:     offset $ROOT_OFFSET, length $ROOT_LENGTH"

mkdosfs -n boot -F 32 -v $BOOT_DEV > /dev/null
mkfs.ext4 -O ^huge_file $ROOT_DEV > /dev/null

mount -v $ROOT_DEV ${ROOTFS_DIR***REMOVED*** -t ext4
mkdir -p ${ROOTFS_DIR***REMOVED***/boot
mount -v $BOOT_DEV ${ROOTFS_DIR***REMOVED***/boot -t vfat

rsync -aHAXx --exclude var/cache/apt/archives ${EXPORT_ROOTFS_DIR***REMOVED***/ ${ROOTFS_DIR***REMOVED***/
