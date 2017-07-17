***REMOVED***

install -m 644 files/regenerate_ssh_host_keys.service	${ROOTFS_DIR***REMOVED***/lib/systemd/system/
install -m 755 files/apply_noobs_os_config		${ROOTFS_DIR***REMOVED***/etc/init.d/
install -m 755 files/resize2fs_once			${ROOTFS_DIR***REMOVED***/etc/init.d/

install -d						${ROOTFS_DIR***REMOVED***/etc/systemd/system/rc-local.service.d
install -m 644 files/ttyoutput.conf			${ROOTFS_DIR***REMOVED***/etc/systemd/system/rc-local.service.d/

install -m 644 files/50raspi				${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/

install -m 644 files/console-setup   			${ROOTFS_DIR***REMOVED***/etc/default/

install -m 755 files/rc.local				${ROOTFS_DIR***REMOVED***/etc/

on_chroot << ***REMOVED***
systemctl disable hwclock.sh
systemctl disable nfs-common
systemctl disable rpcbind
systemctl disable ssh
systemctl enable regenerate_ssh_host_keys
systemctl enable apply_noobs_os_config
systemctl enable resize2fs_once
***REMOVED***

on_chroot << \***REMOVED***
for GRP in input spi i2c gpio; do
	groupadd -f -r $GRP
done
for GRP in adm dialout cdrom audio users sudo video games plugdev input gpio spi i2c netdev; do
  adduser pi $GRP
done
***REMOVED***

on_chroot << ***REMOVED***
setupcon --force --save-only -v
***REMOVED***

on_chroot << ***REMOVED***
usermod --pass='*' root
***REMOVED***

rm -f ${ROOTFS_DIR***REMOVED***/etc/ssh/ssh_host_*_key*
