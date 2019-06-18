#!/bin/bash

source head.sh
source format.sh
source tools.sh
source errors.sh

shopt -s extglob

YES_PATTERN='@([yY]|[yY][Ee][Ss])'
NO_PATTERN='@([nN]|[n|N][O|o])'

USE_GPG=0

for arg in "$@"; do
	case $arg in
		-d=*)
			FASH_DIRECTORY_ACCOUNTS="${arg#*=}"
			shift			
			;;
	esac
done

new_gpg_ask() {
	read_text_label_bold "Generate new GPG key? (y/N)"
	read ask
	case $ask in
		$YES_PATTERN)
			echo -e "${FORMAT_NORM}"
			gpg --full-gen-key --keyid-format long
			;;
		*)
			;;
	esac
}

use_gpg_ask() {
	read_text_label_bold "Use GPG encryption? (Y/n)"
	read ask
	case $ask in
		$NO_PATTERN)
			;;
		*)
			echo -e "${FORMAT_NORM}"
			USE_GPG=1
			new_gpg_ask
			;;
	esac
}

new_2fa_without_gpg() {
	echo ""
	read_text_label_bold "2FA Label"
	read tfa_label
	[ "$tfa_label" = "" ] && echo_error "Invalid label" && exit 1
	throw_error_if_account_exists "$tfa_label"

	read_text_label "2FA Secret"
	read -s tfa_secret


	account_directory="$FASH_DIRECTORY_ACCOUNTS/$tfa_label"
	secret_file="$account_directory/.secret"
	echo ""
	echo ""
	mkdir -p "$account_directory"

	echo -en "$tfa_secret" > "$secret_file"

	echo -e " ${FORMAT_NORM}Run following command to get the code: "
	echo -e " ${FORMAT_INV}${FORMAT_BOLD}./2fash c $tfa_label${FORMAT_NORM}"
	echo ""

	exit 0
}

new_2fa_with_gpg() {
	echo ""
	read_text_label_bold "GnuPG user id (email)"
	read gpg_uid

	read_text_label_bold "GnuPG key id (format: rsa0000/0000000000000000)"
	read gpg_kid
	echo ""

	read_text_label_bold "2FA Label"
	read tfa_label
	throw_error_if_account_exists "$tfa_label"

	read_text_label "2FA Secret"
	read -s tfa_secret


	account_directory="$FASH_DIRECTORY_ACCOUNTS/$tfa_label"
	gpgdata_file="$account_directory/.gpgdata"
	secret_file="$account_directory/.secret"
	echo ""
	echo ""
	mkdir -p "$account_directory"

	echo -en "uid: $gpg_uid\nkid: $gpg_kid" > "$gpgdata_file"
	echo -en "$tfa_secret" > "$secret_file"

	gpg -u "$gpg_kid" -r "$gpg_uid" --encrypt "$secret_file" && echo -en "\n "; rm "$secret_file"

	echo -e " ${FORMAT_NORM}Run following command to get the code: "
	echo -e " ${FORMAT_INV}${FORMAT_BOLD}./2fash c $tfa_label${FORMAT_NORM}"
	echo ""

	exit 0
}

print_header

use_gpg_ask

[ $USE_GPG = 1 ] && new_2fa_with_gpg || new_2fa_without_gpg