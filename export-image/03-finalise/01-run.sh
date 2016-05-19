***REMOVED***

IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"

on_chroot sh -e - <<***REMOVED***
/etc/init.d/fake-hwclock stop
hardlink -t /usr/share/doc
***REMOVED***

rm -f ${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache
rm -f ${ROOTFS_DIR***REMOVED***/usr/sbin/policy-rc.d
rm -f ${ROOTFS_DIR***REMOVED***/usr/bin/qemu-arm-static
if [ -e ${ROOTFS_DIR***REMOVED***/etc/ld.so.preload.disabled ]; then
        mv ${ROOTFS_DIR***REMOVED***/etc/ld.so.preload.disabled ${ROOTFS_DIR***REMOVED***/etc/ld.so.preload
fi

update_issue $(basename ${EXPORT_DIR***REMOVED***)
install -m 644 ${ROOTFS_DIR***REMOVED***/etc/rpi-issue ${ROOTFS_DIR***REMOVED***/boot/issue.txt
install files/LICENSE.oracle ${ROOTFS_DIR***REMOVED***/boot/

ROOT_DEV=$(mount | grep "${ROOTFS_DIR***REMOVED*** " | cut -f1 -d' ')

unmount ${ROOTFS_DIR***REMOVED***
zerofree -v ${ROOT_DEV***REMOVED***

unmount_image ${IMG_FILE***REMOVED***

mkdir -p ${DEPLOY_DIR***REMOVED***

rm -f ${DEPLOY_DIR***REMOVED***/image_${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.zip

echo zip ${DEPLOY_DIR***REMOVED***/image_${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.zip ${IMG_FILE***REMOVED***
pushd ${STAGE_WORK_DIR***REMOVED*** > /dev/null
zip ${DEPLOY_DIR***REMOVED***/image_${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.zip $(basename ${IMG_FILE***REMOVED***)
popd > /dev/null
