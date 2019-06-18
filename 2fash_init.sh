#!/usr/bin/env bash

source head.sh
source format.sh
source tools.sh
source errors.sh

shopt -s extglob

YES_PATTERN='@([yY]|[yY][Ee][Ss])'
NO_PATTERN='@([nN]|[n|N][O|o])'

USE_GPG=0

ARGS=("$@")

for arg in ${ARGS}; do
	case ${arg} in
		-d=*)
				FASH_DIRECTORY_ACCOUNTS="${arg#*=}"
				shift
			;;
	esac
done

new_gpg_ask() {
	read_text_label_bold "Generate new GPG key? (y/N)"
	read ask
	case ${ask} in
		${YES_PATTERN})
				echo -e "${FORMAT_NORM}"
				gpg --full-gen-key --keyid-format long
			;;
	esac
}

use_gpg_ask() {
	read_text_label_bold "Use GPG encryption? (Y/n)"
	read ask
	case ${ask} in
		${NO_PATTERN})
			;;
		*)
			echo -e "${FORMAT_NORM}"
			USE_GPG=1
			new_gpg_ask
			;;
	esac
}

read_2fa() {
	read_text_label_bold "2FA Label"
	read "$1"
	[[ "$1" = "" ]] && echo_error "Invalid label" && exit 1
	throw_error_if_account_exists "$1"

	read_text_label "2FA Secret"
	read -s "$2"
}

read_gpg_data() {
	echo ""
	read_text_label_bold "GnuPG user id (email)"
	read "$1"

	read_text_label_bold "GnuPG key id (format: rsa0000/0000000000000000)"
	read "$2"
}

print_end() {
	echo -e " ${FORMAT_NORM}Run following command to get the code:"
	echo -e " ${FORMAT_INV}${FORMAT_BOLD}${FASH_COMMAND} c $1${FORMAT_NORM}"
}

new_2fa_without_gpg() {
	echo ""
	read_2fa tfa_label tfa_secret

	account_directory="$FASH_DIRECTORY_ACCOUNTS/$tfa_label"
	secret_file="$account_directory/.secret"
	echo ""
	echo ""
	mkdir -p "$account_directory"

	echo -en "$tfa_secret" > "$secret_file"


	echo ""
	print_end "$tfa_secret"

	exit 0
}

new_2fa_with_gpg() {
	read_gpg_data gpg_uid gpg_kid

	echo ""
	read_2fa tfa_label tfa_secret

	account_directory="$FASH_DIRECTORY_ACCOUNTS/$tfa_label"
	gpgdata_file="$account_directory/.gpgdata"
	secret_file="$account_directory/.secret"
	echo ""
	echo ""
	mkdir -p "$account_directory"

	echo -en "uid: $gpg_uid\nkid: $gpg_kid" > "$gpgdata_file"
	echo -en "$tfa_secret" > "$secret_file"

	gpg -u "$gpg_kid" -r "$gpg_uid" --encrypt "$secret_file" && echo -en "\n "; rm "$secret_file"

	print_end "$tfa_secret"
	echo ""

	exit 0
}

echo ""
use_gpg_ask

[[ ${USE_GPG} = 1 ]] && new_2fa_with_gpg || new_2fa_without_gpg