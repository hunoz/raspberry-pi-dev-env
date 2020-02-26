***REMOVED***
# shellcheck disable=SC2119
run_sub_stage()
{
	log "Begin ${SUB_STAGE_DIR***REMOVED***"
	pushd "${SUB_STAGE_DIR***REMOVED***" > /dev/null
	for i in {00..99***REMOVED***; do
		if [ -f "${i***REMOVED***-debconf" ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-debconf"
			on_chroot << ***REMOVED***
debconf-set-selections <<SEL***REMOVED***
$(cat "${i***REMOVED***-debconf")
SEL***REMOVED***
***REMOVED***

		log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-debconf"
		fi
		if [ -f "${i***REMOVED***-packages-nr" ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages-nr"
			PACKAGES="$(sed -f "${SCRIPT_DIR***REMOVED***/remove-comments.sed" < "${i***REMOVED***-packages-nr")"
			if [ -n "$PACKAGES" ]; then
				on_chroot << ***REMOVED***
apt-get -o APT::Acquire::Retries=3 install --no-install-recommends -y $PACKAGES
***REMOVED***
			fi
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages-nr"
		fi
		if [ -f "${i***REMOVED***-packages" ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages"
			PACKAGES="$(sed -f "${SCRIPT_DIR***REMOVED***/remove-comments.sed" < "${i***REMOVED***-packages")"
			if [ -n "$PACKAGES" ]; then
				on_chroot << ***REMOVED***
apt-get -o APT::Acquire::Retries=3 install -y $PACKAGES
***REMOVED***
			fi
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages"
		fi
		if [ -d "${i***REMOVED***-patches" ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-patches"
			pushd "${STAGE_WORK_DIR***REMOVED***" > /dev/null
			if [ "${CLEAN***REMOVED***" = "1" ]; then
				rm -rf .pc
				rm -rf ./*-pc
			fi
			QUILT_PATCHES="${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-patches"
			SUB_STAGE_QUILT_PATCH_DIR="$(basename "$SUB_STAGE_DIR")-pc"
			mkdir -p "$SUB_STAGE_QUILT_PATCH_DIR"
			ln -snf "$SUB_STAGE_QUILT_PATCH_DIR" .pc
			quilt upgrade
			if [ -e "${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-patches/EDIT" ]; then
				echo "Dropping into bash to edit patches..."
				bash
			fi
			RC=0
			quilt push -a || RC=$?
			case "$RC" in
				0|2)
					;;
				*)
					false
					;;
			esac
			popd > /dev/null
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-patches"
		fi
		if [ -x ${i***REMOVED***-run.sh ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-run.sh"
			./${i***REMOVED***-run.sh
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-run.sh"
		fi
		if [ -f ${i***REMOVED***-run-chroot.sh ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-run-chroot.sh"
			on_chroot < ${i***REMOVED***-run-chroot.sh
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-run-chroot.sh"
		fi
	done
	popd > /dev/null
	log "End ${SUB_STAGE_DIR***REMOVED***"
***REMOVED***


run_stage(){
	log "Begin ${STAGE_DIR***REMOVED***"
	STAGE="$(basename "${STAGE_DIR***REMOVED***")"
	pushd "${STAGE_DIR***REMOVED***" > /dev/null
	unmount "${WORK_DIR***REMOVED***/${STAGE***REMOVED***"
	STAGE_WORK_DIR="${WORK_DIR***REMOVED***/${STAGE***REMOVED***"
	ROOTFS_DIR="${STAGE_WORK_DIR***REMOVED***"/rootfs
	if [ ! -f SKIP_IMAGES ]; then
		if [ -f "${STAGE_DIR***REMOVED***/EXPORT_IMAGE" ]; then
			EXPORT_DIRS="${EXPORT_DIRS***REMOVED*** ${STAGE_DIR***REMOVED***"
		fi
	fi
	if [ ! -f SKIP ]; then
		if [ "${CLEAN***REMOVED***" = "1" ]; then
			if [ -d "${ROOTFS_DIR***REMOVED***" ]; then
				rm -rf "${ROOTFS_DIR***REMOVED***"
			fi
		fi
		if [ -x prerun.sh ]; then
			log "Begin ${STAGE_DIR***REMOVED***/prerun.sh"
			./prerun.sh
			log "End ${STAGE_DIR***REMOVED***/prerun.sh"
		fi
		for SUB_STAGE_DIR in "${STAGE_DIR***REMOVED***"/*; do
			if [ -d "${SUB_STAGE_DIR***REMOVED***" ] &&
			   [ ! -f "${SUB_STAGE_DIR***REMOVED***/SKIP" ]; then
				run_sub_stage
			fi
		done
	fi
	unmount "${WORK_DIR***REMOVED***/${STAGE***REMOVED***"
	PREV_STAGE="${STAGE***REMOVED***"
	PREV_STAGE_DIR="${STAGE_DIR***REMOVED***"
	PREV_ROOTFS_DIR="${ROOTFS_DIR***REMOVED***"
	popd > /dev/null
	log "End ${STAGE_DIR***REMOVED***"
***REMOVED***

if [ "$(id -u)" != "0" ]; then
	echo "Please run as root" 1>&2
	exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]***REMOVED***")" && pwd)"
export BASE_DIR

if [ -f config ]; then
	# shellcheck disable=SC1091
	source config
fi

while getopts "c:" flag
do
	case "$flag" in
		c)
			EXTRA_CONFIG="$OPTARG"
			# shellcheck disable=SC1090
			source "$EXTRA_CONFIG"
			;;
		*)
			;;
	esac
done

export PI_GEN=${PI_GEN:-pi-gen***REMOVED***
export PI_GEN_REPO=${PI_GEN_REPO:-https://github.com/RPi-Distro/pi-gen***REMOVED***

if [ -z "${IMG_NAME***REMOVED***" ]; then
	echo "IMG_NAME not set" 1>&2
	exit 1
fi

export USE_QEMU="${USE_QEMU:-0***REMOVED***"
export IMG_DATE="${IMG_DATE:-"$(date +%Y-%m-%d)"***REMOVED***"
export IMG_FILENAME="${IMG_FILENAME:-"${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***"***REMOVED***"
export ZIP_FILENAME="${ZIP_FILENAME:-"image_${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***"***REMOVED***"

export SCRIPT_DIR="${BASE_DIR***REMOVED***/scripts"
export WORK_DIR="${WORK_DIR:-"${BASE_DIR***REMOVED***/work/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***"***REMOVED***"
export DEPLOY_DIR=${DEPLOY_DIR:-"${BASE_DIR***REMOVED***/deploy"***REMOVED***
export DEPLOY_ZIP="${DEPLOY_ZIP:-1***REMOVED***"
export LOG_FILE="${WORK_DIR***REMOVED***/build.log"

export TARGET_HOSTNAME=${TARGET_HOSTNAME:-raspberrypi***REMOVED***

export FIRST_USER_NAME=${FIRST_USER_NAME:-pi***REMOVED***
export FIRST_USER_PASS=${FIRST_USER_PASS:-raspberry***REMOVED***
export RELEASE=${RELEASE:-buster***REMOVED***
export WPA_ESSID
export WPA_PASSWORD
export WPA_COUNTRY
export ENABLE_SSH="${ENABLE_SSH:-0***REMOVED***"

export LOCALE_DEFAULT="${LOCALE_DEFAULT:-en_GB.UTF-8***REMOVED***"

export KEYBOARD_KEYMAP="${KEYBOARD_KEYMAP:-gb***REMOVED***"
export KEYBOARD_LAYOUT="${KEYBOARD_LAYOUT:-English (UK)***REMOVED***"

export TIMEZONE_DEFAULT="${TIMEZONE_DEFAULT:-Europe/London***REMOVED***"

export GIT_HASH=${GIT_HASH:-"$(git rev-parse HEAD)"***REMOVED***

export CLEAN
export IMG_NAME
export APT_PROXY

export STAGE
export STAGE_DIR
export STAGE_WORK_DIR
export PREV_STAGE
export PREV_STAGE_DIR
export ROOTFS_DIR
export PREV_ROOTFS_DIR
export IMG_SUFFIX
export NOOBS_NAME
export NOOBS_DESCRIPTION
export EXPORT_DIR
export EXPORT_ROOTFS_DIR

export QUILT_PATCHES
export QUILT_NO_DIFF_INDEX=1
export QUILT_NO_DIFF_TIMESTAMPS=1
export QUILT_REFRESH_ARGS="-p ab"

# shellcheck source=scripts/common
source "${SCRIPT_DIR***REMOVED***/common"
# shellcheck source=scripts/dependencies_check
source "${SCRIPT_DIR***REMOVED***/dependencies_check"

dependencies_check "${BASE_DIR***REMOVED***/depends"

#check username is valid
if [[ ! "$FIRST_USER_NAME" =~ ^[a-z][-a-z0-9_]*$ ]]; then
	echo "Invalid FIRST_USER_NAME: $FIRST_USER_NAME"
	exit 1
fi

if [[ -n "${APT_PROXY***REMOVED***" ]] && ! curl --silent "${APT_PROXY***REMOVED***" >/dev/null ; then
	echo "Could not reach APT_PROXY server: ${APT_PROXY***REMOVED***"
	exit 1
fi

if [[ -n "${WPA_PASSWORD***REMOVED***" && ${#WPA_PASSWORD***REMOVED*** -lt 8 || ${#WPA_PASSWORD***REMOVED*** -gt 63  ]] ; then
	echo "WPA_PASSWORD" must be between 8 and 63 characters
	exit 1
fi

mkdir -p "${WORK_DIR***REMOVED***"
log "Begin ${BASE_DIR***REMOVED***"

STAGE_LIST=${STAGE_LIST:-${BASE_DIR***REMOVED***/stage****REMOVED***

for STAGE_DIR in $STAGE_LIST; do
	STAGE_DIR=$(realpath "${STAGE_DIR***REMOVED***")
	run_stage
done

CLEAN=1
for EXPORT_DIR in ${EXPORT_DIRS***REMOVED***; do
	STAGE_DIR=${BASE_DIR***REMOVED***/export-image
	# shellcheck source=/dev/null
	source "${EXPORT_DIR***REMOVED***/EXPORT_IMAGE"
	EXPORT_ROOTFS_DIR=${WORK_DIR***REMOVED***/$(basename "${EXPORT_DIR***REMOVED***")/rootfs
	run_stage
	if [ "${USE_QEMU***REMOVED***" != "1" ]; then
		if [ -e "${EXPORT_DIR***REMOVED***/EXPORT_NOOBS" ]; then
			# shellcheck source=/dev/null
			source "${EXPORT_DIR***REMOVED***/EXPORT_NOOBS"
			STAGE_DIR="${BASE_DIR***REMOVED***/export-noobs"
			run_stage
		fi
	fi
done

if [ -x ${BASE_DIR***REMOVED***/postrun.sh ]; then
	log "Begin postrun.sh"
	cd "${BASE_DIR***REMOVED***"
	./postrun.sh
	log "End postrun.sh"
fi

log "End ${BASE_DIR***REMOVED***"
