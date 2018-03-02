***REMOVED***

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d"
install -v -m 644 files/wait.conf		"${ROOTFS_DIR***REMOVED***/etc/systemd/system/dhcpcd.service.d/"

install -v -d					"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant"
install -v -m 600 files/wpa_supplicant.conf	"${ROOTFS_DIR***REMOVED***/etc/wpa_supplicant/"

