***REMOVED***

IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"
NOOBS_DIR="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***"
unmount_image ${IMG_FILE***REMOVED***

mkdir -p ${STAGE_WORK_DIR***REMOVED***
cp ${WORK_DIR***REMOVED***/export-image/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.img ${STAGE_WORK_DIR***REMOVED***/

rm -rf ${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***

LOOP_DEV=`kpartx -asv ${IMG_FILE***REMOVED*** | grep -E -o -m1 'loop[[:digit:]]+' | head -n 1`
BOOT_DEV=/dev/mapper/${LOOP_DEV***REMOVED***p1
ROOT_DEV=/dev/mapper/${LOOP_DEV***REMOVED***p2

mkdir -p ${STAGE_WORK_DIR***REMOVED***/rootfs
mkdir -p ${NOOBS_DIR***REMOVED***

mount $ROOT_DEV ${STAGE_WORK_DIR***REMOVED***/rootfs
mount $BOOT_DEV ${STAGE_WORK_DIR***REMOVED***/rootfs/boot

bsdtar --format gnutar --use-compress-program pxz -C ${STAGE_WORK_DIR***REMOVED***/rootfs/boot -cpf ${NOOBS_DIR***REMOVED***/boot.tar.xz .
bsdtar --format gnutar --use-compress-program pxz -C ${STAGE_WORK_DIR***REMOVED***/rootfs --one-file-system -cpf ${NOOBS_DIR***REMOVED***/root.tar.xz .

unmount_image ${IMG_FILE***REMOVED***
