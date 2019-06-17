#!/bin/bash

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

for arg in "$@"; do
	case $arg in
		-d=*)
			TWOFA_DIRECTORY="${arg#*=}"
			shift			
			;;
	esac
done


new_gpg_ask() {
	echo -en " Generate new GPG key? (y/N): "
	read ask
	case $ask in
		$YES_PATTERN)
			echo ""
			echo -en "\tConfiguration you sould use:\n"
			echo -en "\t 1) RSA and RSA\n"
			echo -en "\t 2) 4096 bits\n"
			echo -en "\t 3) key does not expire\n"
			echo -en "\t    ...\n"
			echo ""
			gpg2 --full-gen-key --keyid-format long
			;;
		$NO_PATTERN) 
			;;
		*)
			;;
	esac
}

new_2fa() {
	echo ""
	echo -en " GnuPG user id (email): "
	read gpg_uid

	echo -en " GnuPG key id (format: rsa4096/0000000000000000): "
	read gpg_kid

	echo -en " 2FA Label: "
	read tfa_label
	[ -d "$TWOFA_DIRECTORY/$tfa_label" ] && echo "Error: label already exists" && exit 1	

	echo -en " 2FA Secret: "
	read -s tfa_secret


	service_directory="$TWOFA_DIRECTORY/$tfa_label"
	gpgdata_file="$service_directory/.gpgdata"
	secret_file="$service_directory/.secret"
	mkdir -p "$service_directory"

	echo -en "uid: $gpg_uid\nkid: $gpg_kid" > "$gpgdata_file"
	echo -en "$tfa_secret" > "$secret_file"

	gpg2 -u "$gpg_kid" -r "$gpg_uid" --encrypt "$secret_file" && echo -en "\n "; rm -i "$secret_file"

	echo ""
	echo " Run following command to get code: "
	echo " ./2fa $tfa_label"

	exit 0
}

new_gpg_ask

new_2fa