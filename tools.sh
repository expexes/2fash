#!/bin/bash

source head.sh
source format.sh

check_deps() {
	to_install_arch=()
	to_install_fedora=()
	to_install_ubuntu=()

	install_deps=0

	! [[ -x "$(command -v oathtool)" ]] && install_deps=1 && to_install_arch+=('oath-toolkit') && to_install_fedora+=('oathtool') && to_install_ubuntu+=('oathtool')
	! [[ -x "$(command -v gpg)" ]] && install_deps=1 && to_install_arch+=('gpg gnupg') && to_install_fedora+=('gnupg2') && to_install_ubuntu+=('gpg gpgv2')

	if [[ "$install_deps" == "1" ]]; then
		echo_error "install dependencies"
		echo -e " Arch\t${FORMAT_BOLD}sudo pacman -S ${to_install_arch[@]}${FORMAT_NORM}"
		echo -e " Fedora\t${FORMAT_BOLD}sudo dnf install ${to_install_fedora[@]}${FORMAT_NORM}"
		echo -e " Ubuntu\t${FORMAT_BOLD}sudo apt install ${to_install_ubuntu[@]}${FORMAT_NORM}"
		echo ""
		exit 2
	fi
}

is_account_exists() {
	[[ -d "$FASH_DIRECTORY_ACCOUNTS/$1" ]] && echo 1 || echo 0
}

is_account_encrypted() {
	[[ -f "$FASH_DIRECTORY_ACCOUNTS/$1/.gpgdata" ]] && echo 1 || echo 0
}


print_help_usage_head() {
	echo -e " ${FORMAT_BOLD}USAGE:${FORMAT_NORM} $@"
}

print_help_head() {
	echo -e " ${FORMAT_BOLD}$@:${FORMAT_NORM}"
}

print_help_command() {
	echo -e "\t$1 \t- $2"
}