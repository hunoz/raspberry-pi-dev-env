***REMOVED***

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d"
install -v -m 644 files/wait.conf		"${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d/"

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/"

if [ -v WPA_COUNTRY ]
then
	echo "country=${WPA_COUNTRY***REMOVED***" >> "${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/wpa_supplicant.conf"
fi

if [ -v WPA_ESSID -a -v WPA_PASSWORD ]
then
on_chroot <<***REMOVED***
wpa_passphrase ${WPA_ESSID***REMOVED*** ${WPA_PASSWORD***REMOVED*** >> "/etc/wpa_supplicant/wpa_supplicant.conf"
***REMOVED***
fi
