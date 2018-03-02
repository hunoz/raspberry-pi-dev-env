***REMOVED***

ln -sf /etc/systemd/system/autologin@.service \
	"${ROOTFS_DIR***REMOVED***/etc/systemd/system/getty.target.wants/getty@tty1.service"
