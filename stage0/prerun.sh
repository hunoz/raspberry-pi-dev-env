***REMOVED***

if [ "$RELEASE" != "bookworm" ]; then
	echo "WARNING: RELEASE does not match the intended option for this branch."
	echo "         Please check the relevant README.md section."
fi

if [ ! -d "${ROOTFS_DIR***REMOVED***" ] || [ "${USE_QCOW2***REMOVED***" = "1" ]; then
	bootstrap ${RELEASE***REMOVED*** "${ROOTFS_DIR***REMOVED***" http://raspbian.raspberrypi.com/raspbian/
fi
