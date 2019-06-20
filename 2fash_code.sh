#!/usr/bin/env bash

source head.sh
source format.sh
source tools.sh
source errors.sh

ACCOUNT=""
ACCOUNT_DIRECTORY=""

for arg in $@; do
	case ${arg} in
		-d=*)
			FASH_DIRECTORY="${arg#*=}"
			shift
		;;
		-a=*)
			ACCOUNT="${arg#*=}"
			ACCOUNT_DIRECTORY="${FASH_DIRECTORY_ACCOUNTS}/${ACCOUNT}"
			shift
		;;
	esac
done

GPGDATA_FILE="$ACCOUNT_DIRECTORY/.gpgdata"
SECRET_FILE="$ACCOUNT_DIRECTORY/.secret"
SECRET_GPG_FILE="$ACCOUNT_DIRECTORY/.secret.gpg"

if [[ $(is_account_encrypted "$ACCOUNT") == 1 ]]; then
	gpg_uid=$(cat "$GPGDATA_FILE" | grep uid | head --lines 1 | cut -b 5- | tr -d ' ')
	gpg_kid=$(cat "$GPGDATA_FILE" | grep kid | head --lines 1 | cut -b 5- | tr -d ' ')

	totp=$(gpg --quiet -u "$gpg_kid" -r "$gpg_kid" --decrypt "$SECRET_GPG_FILE")
else
	throw_error_if_account_secret_doesnt_exist "$ACCOUNT"

	totp=$(cat "$SECRET_FILE")
fi

oathtool -b --totp "$totp"