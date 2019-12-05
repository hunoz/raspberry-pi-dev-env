***REMOVED***

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d"
install -v -m 644 files/wait.conf		"${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d/"

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/"

if [ -v WPA_COUNTRY ]; then
	echo "country=${WPA_COUNTRY***REMOVED***" >> "${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/wpa_supplicant.conf"
fi

if [ -v WPA_ESSID ] && [ -v WPA_PASSWORD ]; then
on_chroot <<***REMOVED***
wpa_passphrase "${WPA_ESSID***REMOVED***" "${WPA_PASSWORD***REMOVED***" >> "/etc/wpa_supplicant/wpa_supplicant.conf"
***REMOVED***
elif [ -v WPA_ESSID ]; then
cat >> "${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/wpa_supplicant.conf" << EOL

***REMOVED***
	ssid="${WPA_ESSID***REMOVED***"
	key_mgmt=NONE
***REMOVED***
EOL
fi

# Disable wifi on 5GHz models
mkdir -p "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/"
echo 1 > "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/platform-3f300000.mmc:wlan"
echo 1 > "${ROOTFS_DIR***REMOVED***/var/lib/systemd/rfkill/platform-fe300000.mmc:wlan"
