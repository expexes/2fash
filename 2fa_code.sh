#!/bin/bash

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
secret_gpg_file="$service_directory/.secret.gpg"

gpg_uid=$(cat "$gpgdata_file" | grep uid | head --lines 1 | cut -b 5- | tr -d ' ')
gpg_kid=$(cat "$gpgdata_file" | grep kid | head --lines 1 | cut -b 5- | tr -d ' ')

totp=$(gpg2 --quiet -u "$gpg_kid" -r "$gpg_kid" --decrypt "$secret_gpg_file")
oathtool -b --totp "$totp"