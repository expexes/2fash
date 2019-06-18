#!/bin/bash

source format.sh

check_deps


TWOFA_DIRECTORY="$HOME/.2fa"
service_directory="$TWOFA_DIRECTORY/$1"

for arg in "$@"; do
	case $arg in
		-d=*)
			TWOFA_DIRECTORY="${arg#*=}"
			shift			
			;;
		-s=*)
			service_directory="${arg#*=}"
			shift			
			;;
		*)
			;;
	esac
done

gpgdata_file="$service_directory/.gpgdata"
secret_file="$service_directory/.secret"
secret_gpg_file="$service_directory/.secret.gpg"

totp=""
if [ -f "$gpgdata_file" ] ; then
	gpg_uid=$(cat "$gpgdata_file" | grep uid | head --lines 1 | cut -b 5- | tr -d ' ')
	gpg_kid=$(cat "$gpgdata_file" | grep kid | head --lines 1 | cut -b 5- | tr -d ' ')

	totp=$(gpg2 --quiet -u "$gpg_kid" -r "$gpg_kid" --decrypt "$secret_gpg_file")
else
	if [ -f "$secret_file" ] ; then
		totp=$(cat "$secret_file")
	else
		echo "Secret file does not exist"
		exit 1
	fi
fi

oathtool -b --totp "$totp"