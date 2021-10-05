***REMOVED***

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/"

on_chroot << ***REMOVED***
	SUDO_USER="${FIRST_USER_NAME***REMOVED***" raspi-config nonint do_boot_wait 0
***REMOVED***

if [ -v WPA_COUNTRY ]; then
	echo "country=${WPA_COUNTRY***REMOVED***" >> "${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/wpa_supplicant.conf"
fi

if [ -v WPA_ESSID ] && [ -v WPA_PASSWORD ]; then
on_chroot <<***REMOVED***
set -o pipefail
wpa_passphrase "${WPA_ESSID***REMOVED***" "${WPA_PASSWORD***REMOVED***" | tee -a "/etc/wpa_supplicant/wpa_supplicant.conf"
***REMOVED***
elif [ -v WPA_ESSID ]; then
cat >> "${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/wpa_supplicant.conf" << EOL

***REMOVED***
	ssid="${WPA_ESSID***REMOVED***"
	key_mgmt=NONE
***REMOVED***
EOL
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
