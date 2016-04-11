***REMOVED***

run_sub_stage()
{
	log "Begin ${SUB_STAGE_DIR***REMOVED***"
	pushd ${SUB_STAGE_DIR***REMOVED*** > /dev/null
	for i in {00..99***REMOVED***; do
		if [ -f ${i***REMOVED***-debconf ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-debconf"
			on_chroot sh -e - << ***REMOVED***
debconf-set-selections <<SEL***REMOVED***
`cat ${i***REMOVED***-debconf`
SEL***REMOVED***
***REMOVED***
		log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-debconf"
		fi
		if [ -f ${i***REMOVED***-packages-nr ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages-nr"
			PACKAGES=`cat $i-packages-nr | tr '\n' ' '`
			if [ -n "$PACKAGES" ]; then
				on_chroot sh -e - << ***REMOVED***
apt-get install --no-install-recommends -y $PACKAGES
***REMOVED***
			fi
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages-nr"
		fi
		if [ -f ${i***REMOVED***-packages ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages"
			PACKAGES=`cat $i-packages | tr '\n' ' '`
			if [ -n "$PACKAGES" ]; then
				on_chroot sh -e - << ***REMOVED***
apt-get install -y $PACKAGES
***REMOVED***
			fi
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-packages"
		fi
		if [ -d ${i***REMOVED***-patches ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-patches"
			pushd ${STAGE_WORK_DIR***REMOVED*** > /dev/null
			if [ "${CLEAN***REMOVED***" = "1" ]; then
				rm -rf .pc
				rm -rf *-pc
			fi
			QUILT_PATCHES=${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-patches
			mkdir -p ${i***REMOVED***-pc
			ln -sf .pc ${i***REMOVED***-pc
			if [ -e ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-patches/EDIT ]; then
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
		if [ -f ${i***REMOVED***-run-chroot ]; then
			log "Begin ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-run-chroot"
			on_chroot sh -e - < ${i***REMOVED***-run-chroot
			log "End ${SUB_STAGE_DIR***REMOVED***/${i***REMOVED***-run-chroot"
		fi
	done
	popd > /dev/null
	log "End ${SUB_STAGE_DIR***REMOVED***"
***REMOVED***

run_stage(){
	log "Begin ${STAGE_DIR***REMOVED***"
	pushd ${STAGE_DIR***REMOVED*** > /dev/null
	unmount ${WORK_DIR***REMOVED***/${STAGE***REMOVED***
	STAGE_WORK_DIR=${WORK_DIR***REMOVED***/${STAGE***REMOVED***
	ROOTFS_DIR=${STAGE_WORK_DIR***REMOVED***/rootfs
	if [ ! -f SKIP ]; then
		if [ "${CLEAN***REMOVED***" = "1" ]; then
			if [ -d ${ROOTFS_DIR***REMOVED*** ]; then
				rm -rf ${ROOTFS_DIR***REMOVED***
			fi
		fi
		if [ -x prerun.sh ]; then
			log "Begin ${STAGE_DIR***REMOVED***/prerun.sh"
			./prerun.sh
			log "End ${STAGE_DIR***REMOVED***/prerun.sh"
		fi
		for SUB_STAGE_DIR in ${STAGE_DIR***REMOVED***/*; do
			if [ -d ${SUB_STAGE_DIR***REMOVED*** ]; then
				run_sub_stage
			fi
		done
	fi
	unmount ${WORK_DIR***REMOVED***/${STAGE***REMOVED***
	PREV_STAGE=${STAGE***REMOVED***
	PREV_STAGE_DIR=${STAGE_DIR***REMOVED***
	PREV_ROOTFS_DIR=${ROOTFS_DIR***REMOVED***
	popd > /dev/null
	log "End ${STAGE_DIR***REMOVED***"
***REMOVED***

if [ "$(id -u)" != "0" ]; then
	echo "Please run as root" 1>&2
	exit 1
fi

if [ -f config ]; then
	source config
fi

if [ -z "${IMG_NAME***REMOVED***" ]; then
	echo "IMG_NAME not set" 1>&2
	exit 1
fi

export IMG_DATE=${IMG_DATE:-"$(date -u +%Y-%m-%d)"***REMOVED***

export BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]***REMOVED***")" && pwd)"
export SCRIPT_DIR="${BASE_DIR***REMOVED***/scripts"
export WORK_DIR="${BASE_DIR***REMOVED***/work/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***"
export LOG_FILE="${WORK_DIR***REMOVED***/build.log"

export CLEAN
export IMG_NAME
export APT_PROXY

export STAGE
export PREV_STAGE
export STAGE_DIR
export PREV_STAGE_DIR
export ROOTFS_DIR
export PREV_ROOTFS_DIR

export QUILT_PATCHES
export QUILT_NO_DIFF_INDEX=1
export QUILT_NO_DIFF_TIMESTAMPS=1
export QUILT_REFRESH_ARGS="-p ab"

source ${SCRIPT_DIR***REMOVED***/common
export -f log
export -f bootstrap
export -f unmount
export -f on_chroot
export -f copy_previous
export -f update_issue

mkdir -p ${WORK_DIR***REMOVED***
log "Begin ${BASE_DIR***REMOVED***"

for STAGE_DIR in ${BASE_DIR***REMOVED***/stage*; do
	STAGE=$(basename ${STAGE_DIR***REMOVED***)
	run_stage
done

log "End ${BASE_DIR***REMOVED***"
