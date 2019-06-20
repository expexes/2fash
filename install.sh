#!/usr/bin/env bash

shopt -s extglob

FASH_COMMAND="2fash"

[[ -z "$FASH_DIRECTORY" ]] && FASH_DIRECTORY="$HOME/.2fash"
[[ -z "$FASH_DIRECTORY_BIN" ]] && FASH_DIRECTORY_BIN="$FASH_DIRECTORY/bin"
[[ -z "$FASH_DIRECTORY_ACCOUNTS" ]] && FASH_DIRECTORY_ACCOUNTS="$FASH_DIRECTORY/accounts"

FASH_DIRECTORY="$HOME/.2fash"
FASH_DIRECTORY_BIN="$FASH_DIRECTORY/bin"
FASH_DIRECTORY_ACCOUNTS="$FASH_DIRECTORY/accounts"

mkdir -p "$FASH_DIRECTORY"
mkdir -p "$FASH_DIRECTORY_ACCOUNTS"

__2fash_check_dependencies() {
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

__2fash_install_bin() {
	echo " ...Copying files to $HOME/.2fash/bin"
	cp -a . "$FASH_DIRECTORY_BIN"
}

__2fash_install_fash_bash() {
	echo " ...Installing for bash"
	[[ $(grep -i "export FASH_DIRECTORY" "$HOME/.bashrc") ]] || echo "" >> "$HOME/.bashrc"
	[[ $(grep -i "export FASH_DIRECTORY" "$HOME/.bashrc") ]] || echo "export FASH_DIRECTORY='$HOME/.2fash'" >> "$HOME/.bashrc"
	[[ $(grep -i 'source "$FASH_DIRECTORY/bin/bash/bash-init.sh"' "$HOME/.bashrc") ]] || echo '[[ -s "$FASH_DIRECTORY/bin/bash/bash-init.sh" ]] && source "$FASH_DIRECTORY/bin/bash/bash-init.sh"' >> "$HOME/.bashrc"
}

__2fash_install_fash_fish() {
	echo " ...Installing for fish"
	mkdir -p "$HOME/.config/fish/functions"
	mkdir -p "$HOME/.config/fish/completions"

	cp -r ./fish/.config $HOME
}

__2fash_install_fash() {
	echo ""

	if [[ -d "$FASH_DIRECTORY_BIN" ]]; then
		echo -en "You already have 2fash installed. Do you really want to install again? (y/N): "
		read really < /dev/tty

		[[ ! ${really} =~ [yY]|[yY][eE][sS] ]] && exit 0

		rm -rf "$FASH_DIRECTORY_BIN"
	fi

	mkdir -p "$FASH_DIRECTORY_BIN"

	__2fash_install_bin
	__2fash_install_fash_bash
	__2fash_install_fash_fish

	echo ""
	echo " Done"
	echo " If you are in bash then restart the terminal or run the following command:"
	echo ""
	echo -e " source $FASH_DIRECTORY/bin/bash/bash-init.sh"
	echo ""

}

__2fash_check_dependencies
__2fash_install_fash

exit 0