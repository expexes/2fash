#!/usr/bin/env bash

# -------------------------------------------------------

GIT_CLONE_REPO="https://gitlab.com/expexes/2fash"
GIT_CLONE_DESTINATION="/tmp/2fash-git"

# -------------------------------------------------------

FORMAT_DEFAULT="\e[39m"
FORMAT_NORM="\e[0m"
FORMAT_BOLD="\e[1m"
FORMAT_DIM="\e[2m"
FORMAT_UNDERLINE="\e[4m"
FORMAT_BLINK="\e[5m"
FORMAT_INV="\e[7m"

FORMAT_RED="\e[31m"
FORMAT_LRED="\e[91m"

FORMAT_GREEN="\e[32m"
FORMAT_LGREEN="\e[92m"

FORMAT_GREEN="\e[32m"
FORMAT_LGREEN="\e[92m"

FORMAT_BLACK="\e[30m"
FORMAT_WHITE="\e[97m"
FORMAT_LGRAY="\e[37m"
FORMAT_DGRAY="\e[90m"

FORMAT_YELLOW="\e[33m"
FORMAT_LYELLOW="\e[93m"

FORMAT_BLUE="\e[34m"
FORMAT_LBLUE="\e[94m"

FORMAT_MAGENTA="\e[35m"
FORMAT_LMAGENTA="\e[95m"

FORMAT_CYAN="\e[36m"
FORMAT_LCYAN="\e[96m"

echo_error() {
	echo -e "\n ${FORMAT_NORM}${FORMAT_RED}${FORMAT_BOLD}Error: ${FORMAT_NORM}${1}\n"
}

check_deps() {
	to_install_arch=()
	to_install_fedora=()
	to_install_ubuntu=()

	install_deps=0

	! [[ -x "$(command -v oathtool)" ]] && install_deps=1 && to_install_arch+=('oath-toolkit') && to_install_fedora+=('oathtool') && to_install_ubuntu+=('oathtool')
	! [[ -x "$(command -v gpg)" ]] && install_deps=1 && to_install_arch+=('gpg gnupg') && to_install_fedora+=('gnupg2') && to_install_ubuntu+=('gpg gpgv2')
	! [[ -x "$(command -v git)" ]] && install_deps=1 && to_install_arch+=('git') && to_install_fedora+=('git') && to_install_ubuntu+=('git')

	if [[ "$install_deps" == "1" ]]; then
		echo_error "install dependencies"
		echo -e " Arch\t${FORMAT_BOLD}sudo pacman -S ${to_install_arch[@]}${FORMAT_NORM}"
		echo -e " Fedora\t${FORMAT_BOLD}sudo dnf install ${to_install_fedora[@]}${FORMAT_NORM}"
		echo -e " Ubuntu\t${FORMAT_BOLD}sudo apt install ${to_install_ubuntu[@]}${FORMAT_NORM}"
		echo ""
		exit 2
	fi
}

check_deps

git clone "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" && cd "$GIT_CLONE_DESTINATION" && bash install.sh