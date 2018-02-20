***REMOVED***

IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"
INFO_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.info"

on_chroot << ***REMOVED***
/etc/init.d/fake-hwclock stop
hardlink -t /usr/share/doc
***REMOVED***

if [ -d ${ROOTFS_DIR***REMOVED***/home/pi/.config ]; then
	chmod 700 ${ROOTFS_DIR***REMOVED***/home/pi/.config
fi

rm -f ${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/51cache
rm -f ${ROOTFS_DIR***REMOVED***/usr/bin/qemu-arm-static

rm -f ${ROOTFS_DIR***REMOVED***/etc/apt/sources.list~
rm -f ${ROOTFS_DIR***REMOVED***/etc/apt/trusted.gpg~

rm -f ${ROOTFS_DIR***REMOVED***/etc/passwd-
rm -f ${ROOTFS_DIR***REMOVED***/etc/group-
rm -f ${ROOTFS_DIR***REMOVED***/etc/shadow-
rm -f ${ROOTFS_DIR***REMOVED***/etc/gshadow-

rm -f ${ROOTFS_DIR***REMOVED***/var/cache/debconf/*-old
rm -f ${ROOTFS_DIR***REMOVED***/var/lib/dpkg/*-old

rm -f ${ROOTFS_DIR***REMOVED***/usr/share/icons/*/icon-theme.cache

rm -f ${ROOTFS_DIR***REMOVED***/var/lib/dbus/machine-id

true > ${ROOTFS_DIR***REMOVED***/etc/machine-id

ln -nsf /proc/mounts ${ROOTFS_DIR***REMOVED***/etc/mtab

for _FILE in $(find ${ROOTFS_DIR***REMOVED***/var/log/ -type f); do
	true > ${_FILE***REMOVED***
done

rm -f "${ROOTFS_DIR***REMOVED***/root/.vnc/private.key"
rm -f "${ROOTFS_DIR***REMOVED***/etc/vnc/updateid"

update_issue $(basename ${EXPORT_DIR***REMOVED***)
install -m 644 ${ROOTFS_DIR***REMOVED***/etc/rpi-issue ${ROOTFS_DIR***REMOVED***/boot/issue.txt
install files/LICENSE.oracle ${ROOTFS_DIR***REMOVED***/boot/


cp "$ROOTFS_DIR/etc/rpi-issue" "$INFO_FILE"

firmware=$(zgrep "firmware as of" "$ROOTFS_DIR/usr/share/doc/raspberrypi-kernel/changelog.Debian.gz" | \
	head -n1 | \
	sed  -n 's|.* \([^ ]*\)$|\1|p')

printf "\nFirmware: https://github.com/raspberrypi/firmware/tree/%s\n" "$firmware" >> "$INFO_FILE"

kernel=$(curl -s -L "https://github.com/raspberrypi/firmware/raw/$firmware/extra/git_hash")
printf "Kernel: https://github.com/raspberrypi/linux/tree/%s\n" "$kernel" >> "$INFO_FILE"

uname=$(curl -s -L "https://github.com/raspberrypi/firmware/raw/$firmware/extra/uname_string7")
printf "Uname string: %s\n" "$uname" >> "$INFO_FILE"

printf "\nPackages:\n">> "$INFO_FILE"
dpkg -l --root "$ROOTFS_DIR" >> "$INFO_FILE"

ROOT_DEV=$(mount | grep "${ROOTFS_DIR***REMOVED*** " | cut -f1 -d' ')

unmount ${ROOTFS_DIR***REMOVED***
zerofree -v ${ROOT_DEV***REMOVED***

unmount_image ${IMG_FILE***REMOVED***

mkdir -p ${DEPLOY_DIR***REMOVED***

rm -f ${DEPLOY_DIR***REMOVED***/image_${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.zip

pushd ${STAGE_WORK_DIR***REMOVED*** > /dev/null
zip ${DEPLOY_DIR***REMOVED***/image_${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***.zip $(basename ${IMG_FILE***REMOVED***)
popd > /dev/null

cp "$INFO_FILE" "$DEPLOY_DIR"
