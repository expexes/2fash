#!/bin/bash

source format.sh

echo ""
echo -en "\t ____  _____ _\n"
echo -en "\t|___ \|  ___/ _\\n"
echo -en "\t  __) | |_ / _ _\\n"
echo -en "\t / __/|  _/ ___ _\\n"
echo -en "\t|_____|_|/_/   \__\\n"
echo ""
echo ""



shopt -s extglob
YES_PATTERN='@([yY]|[yY][Ee][Ss])'
NO_PATTERN='@([nN]|[n|N][O|o])'
TWOFA_DIRECTORY="$HOME/.2fa"

USE_GPG=0

for arg in "$@"; do
	case $arg in
		-d=*)
			TWOFA_DIRECTORY="${arg#*=}"
			shift			
			;;
	esac
done

read_text_label() {
	echo -en " ${FORMAT_NORM}${1}: ${FORMAT_BOLD}${2}"
}

new_gpg_ask() {
	read_text_label "Generate new GPG key? (y/N)"
	read ask
	case $ask in
		$YES_PATTERN)
			echo -e "${FORMAT_NORM}"
			gpg2 --full-gen-key --keyid-format long
			;;
		*)
			;;
	esac
}

use_gpg_ask() {
	read_text_label "Use GPG encryption? (Y/n)"
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
	read_text_label "2FA Label"
	read tfa_label
	[ -d "$TWOFA_DIRECTORY/$tfa_label" ] && echo_error "label already exists" && exit 1	

	read_text_label "2FA Secret"
	read -s tfa_secret


	service_directory="$TWOFA_DIRECTORY/$tfa_label"
	secret_file="$service_directory/.secret"
	mkdir -p "$service_directory"

	echo -en "$tfa_secret" > "$secret_file"

	echo ""
	echo ""
	echo -e " ${FORMAT_NORM}Run following command to get the code: "
	echo -e " ${FORMAT_INV}${FORMAT_BOLD}./2fa c $tfa_label${FORMAT_NORM}"
	echo ""

	exit 0
}

new_2fa_with_gpg() {
	echo ""
	read_text_label "GnuPG user id (email)"
	read gpg_uid

	read_text_label "GnuPG key id (format: rsa0000/0000000000000000)"
	read gpg_kid
	echo ""

	read_text_label "2FA Label"
	read tfa_label
	[ -d "$TWOFA_DIRECTORY/$tfa_label" ] && echo_error "label already exists" && exit 1	

	read_text_label "2FA Secret"
	read -s tfa_secret


	service_directory="$TWOFA_DIRECTORY/$tfa_label"
	gpgdata_file="$service_directory/.gpgdata"
	secret_file="$service_directory/.secret"
	mkdir -p "$service_directory"

	echo -en "uid: $gpg_uid\nkid: $gpg_kid" > "$gpgdata_file"
	echo -en "$tfa_secret" > "$secret_file"

	gpg2 -u "$gpg_kid" -r "$gpg_uid" --encrypt "$secret_file" && echo -en "\n "; rm "$secret_file"

	echo ""
	echo ""
	echo -e " ${FORMAT_NORM}Run following command to get the code: "
	echo -e " ${FORMAT_INV}${FORMAT_BOLD}./2fa c $tfa_label${FORMAT_NORM}"
	echo ""

	exit 0
}

use_gpg_ask

[ $USE_GPG = 1 ] && new_2fa_with_gpg || new_2fa_without_gpg