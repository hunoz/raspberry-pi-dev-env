#!/bin/bash

SED_DELIMITER=$'\03'

CONFIG_PATH="$(pwd)/config"
IMG_NAME="sloop"
TARGET_HOSTNAME="sloop"
PUBKEY=""
TIMEZONE="Etc/UTC"
USERNAME="root"
USER_PASS=""
PUBKEY_ONLY_SSH="true"
CODE_SERVER_WORKSPACE="/workspace"

display_usage() {
  cat << EOF
Usage: $(basename $0) [OPTIONS...] [ -p | -s ]
  -a: The hostname that the Raspberry Pi will be assigned
        (default: sloop)
  -c: The location of the config file for pi-gen to use
        (default: $CONFIG_PATH)
  -i: The name to give the image. Affects end result filename
        (default: $IMG_NAME)
  -o: If specified, will set SSH to allow password authentication
        (default: $PUBKEY_ONLY_SSH)
  -p: The public key to authorize for connections to the configured user. If not set, -s must be set
        (default: ${PUBKEY:-\"\"})
  -s: The password to assign to the configured user. If not set, -p must be set
        (default: ${USER_PASS:-\"\"})
  -t: The timezone that the Raspberry Pi will use
        (default: $TIMEZONE)
  -u: The username to assign to the configured user
	(default: $USERNAME)
  -w: The workspace directory that Code Server and Syncthing will use for default configurations
        (default: $CODE_SERVER_WORKSPACE)
  -h: Display this message
EOF
}

# ':: after the option letter indicates that it is optional. Exclude the colon if an argument is not required for the option.
while getopts 'a::c::i::op::t::u::s::w::h' opt
do
  case "$opt" in
    a) TARGET_HOSTNAME="$OPTARG";;
    c) CONFIG_PATH="$OPTARG";;
    i) IMG_NAME="$OPTARG";;
    o) PUBKEY_ONLY_SSH="false";;
    p) PUBKEY="$OPTARG";;
    s) USER_PASS="$OPTARG";;
    t) TIMEZONE="$OPTARG";;
    u) USERNAME="$OPTARG";;
    w) CODE_SERVER_WORKSPACE="$OPTARG";;
    h) display_usage && exit 0;;
    *) display_usage && exit 1;;
  esac
done

# Sanitize the config path to make sure it's a filepath
CONFIG_PATH=$(dirname "$CONFIG_PATH")/$(basename "$CONFIG_PATH")

if ! [ -f "$CONFIG_PATH" ]; then
  mkdir -p $(dirname "$CONFIG_PATH")
  touch "$CONFIG_PATH"
fi

if [ -z "$PUBKEY" ] && [ -z "$USER_PASS" ] && ! ( cat "$CONFIG_PATH" | grep -q 'PUBKEY_SSH_FIRST_USER' || cat "$CONFIG_PATH" | grep -q 'FIRST_USER_PASS' ); then
  echo "One of -p (public key) or -s (password) must be specified"
  exit 1
fi

if ! [ -f "$CONFIG_PATH" ]; then
  mkdir -p $(dirname "$CONFIG_PATH")
  touch "$CONFIG_PATH"
fi

if cat "$CONFIG_PATH" | grep -q 'CONFIG_PATH'; then
  sed -i "s${SED_DELIMITER}CONFIG_PATH=.*${SED_DELIMITER}CONFIG_PATH=\"$CONFIG_PATH\"${SED_DELIMITER}g" "$CONFIG_PATH"
else
  echo "CONFIG_PATH=\"$CONFIG_PATH\"" >> "$CONFIG_PATH"
fi

if cat "$CONFIG_PATH" | grep -q 'IMG_NAME'; then
  sed -i "s${SED_DELIMITER}IMG_NAME=.*${SED_DELIMITER}IMG_NAME=\"$IMG_NAME\"${SED_DELIMITER}g" "$CONFIG_PATH"
else
  echo "IMG_NAME=\"$IMG_NAME\"" >> "$CONFIG_PATH"
fi

if cat "$CONFIG_PATH" | grep -q 'TARGET_HOSTNAME'; then
  sed -i "s${SED_DELIMITER}TARGET_HOSTNAME=.*${SED_DELIMITER}TARGET_HOSTNAME=\"$TARGET_HOSTNAME\"${SED_DELIMITER}g" "$CONFIG_PATH"
else
  echo "TARGET_HOSTNAME=\"$TARGET_HOSTNAME\"" >> "$CONFIG_PATH"
fi

if cat "$CONFIG_PATH" | grep -q 'FIRST_USER_NAME'; then
  sed -i "s${SED_DELIMITER}FIRST_USER_NAME=.*${SED_DELIMITER}FIRST_USER_NAME=\"$USERNAME\"${SED_DELIMITER}g" "$CONFIG_PATH"
else
  echo "FIRST_USER_NAME=\"$USERNAME\"" >> "$CONFIG_PATH"
fi

if cat "$CONFIG_PATH" | grep -q 'ENABLE_SSH'; then
  sed -i 's/ENABLE_SSH=.*/ENABLE_SSH=1/g' "$CONFIG_PATH"
else
  echo "ENABLE_SSH=1" >> "$CONFIG_PATH"
fi

if ! [ -z "$PUBKEY" ]; then
  if cat "$CONFIG_PATH" | grep -q 'PUBKEY_SSH_FIRST_USER'; then
    sed -i "s${SED_DELIMITER}PUBKEY_SSH_FIRST_USER=.*${SED_DELIMITER}PUBKEY_SSH_FIRST_USER=\"$PUBKEY\"${SED_DELIMITER}g" "$CONFIG_PATH"
  else
    echo "PUBKEY_SSH_FIRST_USER=\"$PUBKEY\"" >> "$CONFIG_PATH"
  fi
fi

if ! [ -z "$USER_PASS" ]; then
  if cat "$CONFIG_PATH" | grep -q 'FIRST_USER_PASS'; then
    sed -i "s${SED_DELIMITER}FIRST_USER_PASS=.*${SED_DELIMITER}FIRST_USER_PASS=\"$USER_PASS\"${SED_DELIMITER}g" "$CONFIG_PATH"
  else
    echo "FIRST_USER_PASS=\"$USER_PASS\"" >> "$CONFIG_PATH"
  fi
fi

RESTRICTED_SSH=1
[ "$PUBKEY_ONLY_SSH" = "false" ] && RESTRICTED_SSH=0
if cat "$CONFIG_PATH" | grep -q 'PUBKEY_ONLY_SSH'; then
  sed -i "s/PUBKEY_ONLY_SSH=.*/PUBKEY_ONLY_SSH=$RESTRICTED_SSH/g" "$CONFIG_PATH"
else
  echo "PUBKEY_ONLY_SSH=$RESTRICTED_SSH" >> "$CONFIG_PATH"
fi

if cat "$CONFIG_PATH" | grep -q 'TIMEZONE_DEFAULT'; then
  sed -i "s${SED_DELIMITER}TIMEZONE_DEFAULT=.*${SED_DELIMITER}TIMEZONE_DEFAULT=\"$TIMEZONE\"${SED_DELIMITER}g" "$CONFIG_PATH"
else
  echo "TIMEZONE_DEFAULT=\"$TIMEZONE\"" >> "$CONFIG_PATH"
fi

if cat "$CONFIG_PATH" | grep -q 'CODE_SERVER_WORKSPACE'; then
  sed -i "s${SED_DELIMITER}CODE_SERVER_WORKSPACE=.*${SED_DELIMITER}CODE_SERVER_WORKSPACE=\"$CODE_SERVER_WORKSPACE\"${SED_DELIMITER}g" "$CONFIG_PATH"
else
  echo "CODE_SERVER_WORKSPACE=\"$CODE_SERVER_WORKSPACE\"" >> "$CONFIG_PATH"
fi

$(dirname $(readlink -f $0))/pigen.sh -c "$CONFIG_PATH"
