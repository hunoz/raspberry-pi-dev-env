***REMOVED***

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/"

if [ -v WPA_COUNTRY ]; then
	on_chroot <<- ***REMOVED***
		SUDO_USER="${FIRST_USER_NAME***REMOVED***" raspi-config nonint do_wifi_country "${WPA_COUNTRY***REMOVED***"
	***REMOVED***
fi

# Disable wifi on 5GHz models if WPA_COUNTRY is not set
mkdir -p "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/"
if [ -n "$WPA_COUNTRY" ]; then
    echo 0 > "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/platform-3f300000.mmcnr:wlan"
    echo 0 > "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/platform-fe300000.mmcnr:wlan"
else
    echo 1 > "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/platform-3f300000.mmcnr:wlan"
    echo 1 > "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/platform-fe300000.mmcnr:wlan"
fi
