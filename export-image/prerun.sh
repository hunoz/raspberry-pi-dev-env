***REMOVED***
IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"

unmount_image ${IMG_FILE***REMOVED***

rm -f ${IMG_FILE***REMOVED***

rm -rf ${ROOTFS_DIR***REMOVED***
mkdir -p ${ROOTFS_DIR***REMOVED***

BOOT_SIZE=$(du -sh ${EXPORT_ROOTFS_DIR***REMOVED***/boot -B M | cut -f 1 | tr -d M)
TOTAL_SIZE=$(du -sh ${EXPORT_ROOTFS_DIR***REMOVED*** -B M | cut -f 1 | tr -d M)

IMG_SIZE=$(expr $BOOT_SIZE \* 2 \+ $TOTAL_SIZE \+ 512)M

fallocate -l ${IMG_SIZE***REMOVED*** ${IMG_FILE***REMOVED***
fdisk ${IMG_FILE***REMOVED*** > /dev/null 2>&1 <<***REMOVED***
o
n


8192
+`expr $BOOT_SIZE \* 3`M
p
t
c
n


8192


p
w
***REMOVED***

LOOP_DEV=`kpartx -asv ${IMG_FILE***REMOVED*** | grep -E -o -m1 'loop[[:digit:]]+' | head -n 1`
BOOT_DEV=/dev/mapper/${LOOP_DEV***REMOVED***p1
ROOT_DEV=/dev/mapper/${LOOP_DEV***REMOVED***p2

mkdosfs -n boot -S 512 -s 16 -v $BOOT_DEV > /dev/null
mkfs.ext4 -O ^huge_file $ROOT_DEV > /dev/null

mount -v $ROOT_DEV ${ROOTFS_DIR***REMOVED*** -t ext4
mkdir -p ${ROOTFS_DIR***REMOVED***/boot
mount -v $BOOT_DEV ${ROOTFS_DIR***REMOVED***/boot -t vfat

rsync ${EXPORT_ROOTFS_DIR***REMOVED***/ ${ROOTFS_DIR***REMOVED***/ -aHAX
