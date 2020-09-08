***REMOVED***

install -m 755 files/resize2fs_once	"${ROOTFS_DIR***REMOVED***/etc/init.d/"

install -d				"${ROOTFS_DIR***REMOVED***/etc/systemd/system/rc-local.service.d"
install -m 644 files/ttyoutput.conf	"${ROOTFS_DIR***REMOVED***/etc/systemd/system/rc-local.service.d/"

install -m 644 files/50raspi		"${ROOTFS_DIR***REMOVED***/etc/apt/apt.conf.d/"

install -m 644 files/console-setup   	"${ROOTFS_DIR***REMOVED***/etc/default/"

install -m 755 files/rc.local		"${ROOTFS_DIR***REMOVED***/etc/"

if [ -n "${PUBKEY_SSH_FIRST_USER***REMOVED***" ]; then
	install -v -m 0700 -o 1000 -g 1000 -d "${ROOTFS_DIR***REMOVED***"/home/"${FIRST_USER_NAME***REMOVED***"/.ssh
	echo "${PUBKEY_SSH_FIRST_USER***REMOVED***" >"${ROOTFS_DIR***REMOVED***"/home/"${FIRST_USER_NAME***REMOVED***"/.ssh/authorized_keys
	chown 1000:1000 "${ROOTFS_DIR***REMOVED***"/home/"${FIRST_USER_NAME***REMOVED***"/.ssh/authorized_keys
	chmod 0600 "${ROOTFS_DIR***REMOVED***"/home/"${FIRST_USER_NAME***REMOVED***"/.ssh/authorized_keys
fi

if [ "${PUBKEY_ONLY_SSH***REMOVED***" = "1" ]; then
	sed -i -Ee 's/^#?[[:blank:]]*PubkeyAuthentication[[:blank:]]*no[[:blank:]]*$/PubkeyAuthentication yes/
s/^#?[[:blank:]]*PasswordAuthentication[[:blank:]]*yes[[:blank:]]*$/PasswordAuthentication no/' "${ROOTFS_DIR***REMOVED***"/etc/ssh/sshd_config
fi

on_chroot << ***REMOVED***
systemctl disable hwclock.sh
systemctl disable nfs-common
systemctl disable rpcbind
if [ "${ENABLE_SSH***REMOVED***" == "1" ]; then
	systemctl enable ssh
else
	systemctl disable ssh
fi
systemctl enable regenerate_ssh_host_keys
***REMOVED***

if [ "${USE_QEMU***REMOVED***" = "1" ]; then
	echo "enter QEMU mode"
	install -m 644 files/90-qemu.rules "${ROOTFS_DIR***REMOVED***/etc/udev/rules.d/"
	on_chroot << ***REMOVED***
systemctl disable resize2fs_once
***REMOVED***
	echo "leaving QEMU mode"
else
	on_chroot << ***REMOVED***
systemctl enable resize2fs_once
***REMOVED***
fi

on_chroot <<***REMOVED***
for GRP in input spi i2c gpio; do
	groupadd -f -r "\$GRP"
done
for GRP in adm dialout cdrom audio users sudo video games plugdev input gpio spi i2c netdev; do
  adduser $FIRST_USER_NAME \$GRP
done
***REMOVED***

on_chroot << ***REMOVED***
setupcon --force --save-only -v
***REMOVED***

on_chroot << ***REMOVED***
usermod --pass='*' root
***REMOVED***

rm -f "${ROOTFS_DIR***REMOVED***/etc/ssh/"ssh_host_*_key*
