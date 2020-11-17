***REMOVED***

IMG_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"
INFO_FILE="${STAGE_WORK_DIR***REMOVED***/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.info"

on_chroot << ***REMOVED***
if [ -x /etc/init.d/fake-hwclock ]; then
	/etc/init.d/fake-hwclock stop
fi
if hash hardlink 2>/dev/null; then
	hardlink -t /usr/share/doc
fi
***REMOVED***

if [ -d "${ROOTFS_DIR***REMOVED***/home/${FIRST_USER_NAME***REMOVED***/.config" ]; then
	chmod 700 "${ROOTFS_DIR***REMOVED***/home/${FIRST_USER_NAME***REMOVED***/.config"
fi

rm -f "${ROOTFS_DIR***REMOVED***/usr/bin/qemu-arm-static"

if [ "${USE_QEMU***REMOVED***" != "1" ]; then
	if [ -e "${ROOTFS_DIR***REMOVED***/etc/ld.so.preload.disabled" ]; then
		mv "${ROOTFS_DIR***REMOVED***/etc/ld.so.preload.disabled" "${ROOTFS_DIR***REMOVED***/etc/ld.so.preload"
	fi
fi

rm -f "${ROOTFS_DIR***REMOVED***/etc/network/interfaces.dpkg-old"

rm -f "${ROOTFS_DIR***REMOVED***/etc/apt/sources.list~"
rm -f "${ROOTFS_DIR***REMOVED***/etc/apt/trusted.gpg~"

rm -f "${ROOTFS_DIR***REMOVED***/etc/passwd-"
rm -f "${ROOTFS_DIR***REMOVED***/etc/group-"
rm -f "${ROOTFS_DIR***REMOVED***/etc/shadow-"
rm -f "${ROOTFS_DIR***REMOVED***/etc/gshadow-"
rm -f "${ROOTFS_DIR***REMOVED***/etc/subuid-"
rm -f "${ROOTFS_DIR***REMOVED***/etc/subgid-"

rm -f "${ROOTFS_DIR***REMOVED***"/var/cache/debconf/*-old
rm -f "${ROOTFS_DIR***REMOVED***"/var/lib/dpkg/*-old

rm -f "${ROOTFS_DIR***REMOVED***"/usr/share/icons/*/icon-theme.cache

rm -f "${ROOTFS_DIR***REMOVED***/var/lib/dbus/machine-id"

true > "${ROOTFS_DIR***REMOVED***/etc/machine-id"

ln -nsf /proc/mounts "${ROOTFS_DIR***REMOVED***/etc/mtab"

find "${ROOTFS_DIR***REMOVED***/var/log/" -type f -exec cp /dev/null {***REMOVED*** \;

rm -f "${ROOTFS_DIR***REMOVED***/root/.vnc/private.key"
rm -f "${ROOTFS_DIR***REMOVED***/etc/vnc/updateid"

update_issue "$(basename "${EXPORT_DIR***REMOVED***")"
install -m 644 "${ROOTFS_DIR***REMOVED***/etc/rpi-issue" "${ROOTFS_DIR***REMOVED***/boot/issue.txt"

cp "$ROOTFS_DIR/etc/rpi-issue" "$INFO_FILE"


{
	if [ -f "$ROOTFS_DIR/usr/share/doc/raspberrypi-kernel/changelog.Debian.gz" ]; then
		firmware=$(zgrep "firmware as of" \
			"$ROOTFS_DIR/usr/share/doc/raspberrypi-kernel/changelog.Debian.gz" | \
			head -n1 | sed  -n 's|.* \([^ ]*\)$|\1|p')
		printf "\nFirmware: https://github.com/raspberrypi/firmware/tree/%s\n" "$firmware"

		kernel="$(curl -s -L "https://github.com/raspberrypi/firmware/raw/$firmware/extra/git_hash")"
		printf "Kernel: https://github.com/raspberrypi/linux/tree/%s\n" "$kernel"

		uname="$(curl -s -L "https://github.com/raspberrypi/firmware/raw/$firmware/extra/uname_string7")"
		printf "Uname string: %s\n" "$uname"
	fi

	printf "\nPackages:\n"
	dpkg -l --root "$ROOTFS_DIR"
***REMOVED*** >> "$INFO_FILE"

ROOT_DEV="$(mount | grep "${ROOTFS_DIR***REMOVED*** " | cut -f1 -d' ')"

unmount "${ROOTFS_DIR***REMOVED***"
zerofree "${ROOT_DEV***REMOVED***"

unmount_image "${IMG_FILE***REMOVED***"

mkdir -p "${DEPLOY_DIR***REMOVED***"

rm -f "${DEPLOY_DIR***REMOVED***/${ZIP_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.zip"
rm -f "${DEPLOY_DIR***REMOVED***/${IMG_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.img"

if [ "${DEPLOY_ZIP***REMOVED***" == "1" ]; then
	pushd "${STAGE_WORK_DIR***REMOVED***" > /dev/null
	zip "${DEPLOY_DIR***REMOVED***/${ZIP_FILENAME***REMOVED***${IMG_SUFFIX***REMOVED***.zip" \
		"$(basename "${IMG_FILE***REMOVED***")"
	popd > /dev/null
else
	cp "$IMG_FILE" "$DEPLOY_DIR"
fi

cp "$INFO_FILE" "$DEPLOY_DIR"
