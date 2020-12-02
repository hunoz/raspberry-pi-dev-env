***REMOVED***

NOOBS_DIR="${STAGE_WORK_DIR***REMOVED***/${IMG_DATE***REMOVED***-${IMG_NAME***REMOVED***${IMG_SUFFIX***REMOVED***"

install -v -m 744	files/partition_setup.sh	"${NOOBS_DIR***REMOVED***/"
install -v		files/partitions.json		"${NOOBS_DIR***REMOVED***/"
install -v		files/os.json			"${NOOBS_DIR***REMOVED***/"
install -v		files/OS.png			"${NOOBS_DIR***REMOVED***/"
install -v		files/release_notes.txt		"${NOOBS_DIR***REMOVED***/"

tar -v -c -C		files/marketing			-f "${NOOBS_DIR***REMOVED***/marketing.tar" .

BOOT_SHASUM="$(sha256sum "${NOOBS_DIR***REMOVED***/boot.tar.xz" | cut -f1 -d' ')"
ROOT_SHASUM="$(sha256sum "${NOOBS_DIR***REMOVED***/root.tar.xz" | cut -f1 -d' ')"

BOOT_SIZE="$(xz --robot -l "${NOOBS_DIR***REMOVED***/boot.tar.xz"  | grep totals | cut -f 5)"
ROOT_SIZE="$(xz --robot -l "${NOOBS_DIR***REMOVED***/root.tar.xz"  | grep totals | cut -f 5)"

BOOT_SIZE="$(( BOOT_SIZE / 1024 / 1024 + 1))"
ROOT_SIZE="$(( ROOT_SIZE / 1024 / 1024 + 1))"

BOOT_NOM="256"
ROOT_NOM="$(( ROOT_SIZE + 400 ))"

mv "${NOOBS_DIR***REMOVED***/OS.png" "${NOOBS_DIR***REMOVED***/${NOOBS_NAME// /_***REMOVED***.png"

sed "${NOOBS_DIR***REMOVED***/partitions.json" -i -e "s|BOOT_SHASUM|${BOOT_SHASUM***REMOVED***|"
sed "${NOOBS_DIR***REMOVED***/partitions.json" -i -e "s|ROOT_SHASUM|${ROOT_SHASUM***REMOVED***|"

sed "${NOOBS_DIR***REMOVED***/partitions.json" -i -e "s|BOOT_SIZE|${BOOT_SIZE***REMOVED***|"
sed "${NOOBS_DIR***REMOVED***/partitions.json" -i -e "s|ROOT_SIZE|${ROOT_SIZE***REMOVED***|"

sed "${NOOBS_DIR***REMOVED***/partitions.json" -i -e "s|BOOT_NOM|${BOOT_NOM***REMOVED***|"
sed "${NOOBS_DIR***REMOVED***/partitions.json" -i -e "s|ROOT_NOM|${ROOT_NOM***REMOVED***|"

sed "${NOOBS_DIR***REMOVED***/os.json" -i -e "s|UNRELEASED|${IMG_DATE***REMOVED***|"
sed "${NOOBS_DIR***REMOVED***/os.json" -i -e "s|NOOBS_NAME|${NOOBS_NAME***REMOVED***|"
sed "${NOOBS_DIR***REMOVED***/os.json" -i -e "s|NOOBS_DESCRIPTION|${NOOBS_DESCRIPTION***REMOVED***|"
sed "${NOOBS_DIR***REMOVED***/os.json" -i -e "s|RELEASE|${RELEASE***REMOVED***|"
sed "${NOOBS_DIR***REMOVED***/os.json" -i -e "s|KERNEL|$(cat "${STAGE_WORK_DIR***REMOVED***/kernel_version")|"

sed "${NOOBS_DIR***REMOVED***/release_notes.txt" -i -e "s|UNRELEASED|${IMG_DATE***REMOVED***|"

cp -a "${NOOBS_DIR***REMOVED***" "${DEPLOY_DIR***REMOVED***/"
