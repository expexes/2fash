#!/bin/bash

check_deps() {
	if ! [ -x "$(command -v oathtool)" ]; then
		echo_error "intall oathtool"
		echo -e " Arch\t${FORMAT_BOLD}sudo pacman -S oath-toolkit${FORMAT_NORM}"
		echo -e " Fedora\t${FORMAT_BOLD}sudo dnf install oathtool${FORMAT_NORM}"
		echo -e " Ubuntu\t${FORMAT_BOLD}sudo apt install oathtool${FORMAT_NORM}"
		echo ""
		exit 2
	fi

	if ! [ -x "$(command -v gpg)" ]; then
		echo_error "intall gnupg"
		echo -e " Arch\t${FORMAT_BOLD}sudo pacman -S gnupg${FORMAT_NORM}"
		echo -e " Fedora\t${FORMAT_BOLD}sudo dnf install gnupg2${FORMAT_NORM}"
		echo -e " Ubuntu\t${FORMAT_BOLD}sudo apt install gpgv2${FORMAT_NORM}"
		echo ""
		exit 2
	fi
}

is_account_exists() {
	[ -d "$FASH_DIRECTORY_ACCOUNTS/$1" ] && echo 1 || echo 0
}

is_account_encrypted() {
	[ -f "$FASH_DIRECTORY_ACCOUNTS/$1/.gpgdata" ] && echo 1 || echo 0
}