#!/usr/bin/env bash

ACCOUNT=""
ACCOUNT_DIRECTORY=""
IS_COPY=0

__2fash_print_help_code() {
	echo ""
	__2fash_print_help_usage_head "${FASH_COMMAND} code [ACCOUNT] [OPTION]..."
	echo ""
	__2fash_print_help_head "OPTIONS"
	__2fash_print_help_command "--help, -h" "show help"
	__2fash_print_help_command "--copy, -cp" "copy code to clipboard using xclip"
	__2fash_print_help_command "--force-print, -fp" "print code when using --copy"
	echo ""
}


for arg in $@; do
	case ${arg} in
		--help|-h)
			__2fash_print_help_code
			exit 0
			shift
		;;
		--copy|-cp)
			IS_COPY=1
			shift
		;;
		--force-print|-fp)
			IS_COPY=1
			shift
		;;
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

__2fash_throw_error_if_account_doesnt_exist "$ACCOUNT"

GPGDATA_FILE="$ACCOUNT_DIRECTORY/.gpgdata"
SECRET_FILE="$ACCOUNT_DIRECTORY/.secret"
SECRET_GPG_FILE="$ACCOUNT_DIRECTORY/.secret.gpg"

if [[ "$ACCOUNT" != "" ]]; then
	if [[ $(__2fash_is_account_encrypted "$ACCOUNT") == 1 ]]; then
		gpg_uid=$(cat "$GPGDATA_FILE" | grep uid | head --lines 1 | cut -b 5- | tr -d ' ')
		gpg_kid=$(cat "$GPGDATA_FILE" | grep kid | head --lines 1 | cut -b 5- | tr -d ' ')

		totp=$(gpg --quiet -u "$gpg_kid" -r "$gpg_kid" --decrypt "$SECRET_GPG_FILE") || exit 1
	else
		__2fash_throw_error_if_account_secret_doesnt_exist "$ACCOUNT"

		totp=$(cat "$SECRET_FILE")
	fi

	if ! [[ "$totp" == "" ]]; then
		CODE=$(oathtool -b --totp "$totp")

		[[ ! -z "$CODE" ]] && rhaecho "$CODE"
	fi
else
	__2fash_print_help_code
	exit 0
fi