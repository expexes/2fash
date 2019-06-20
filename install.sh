#!/usr/bin/env bash

shopt -s extglob

source head.sh
source tools.sh

FASH_DIRECTORY="$HOME/.2fash"
FASH_DIRECTORY_BIN="$FASH_DIRECTORY/bin"
FASH_DIRECTORY_ACCOUNTS="$FASH_DIRECTORY/accounts"

mkdir -p "$FASH_DIRECTORY"
mkdir -p "$FASH_DIRECTORY_ACCOUNTS"

install_bin() {
	echo " ...Coping files to ~/.2fash/bin"
	cp -a . "$FASH_DIRECTORY_BIN"
}

install_fash_bash() {
	echo " ...Installing for bash"
	[[ $(grep -i "export FASH_DIRECTORY" "$HOME/.bashrc") ]] || echo ""
	[[ $(grep -i "export FASH_DIRECTORY" "$HOME/.bashrc") ]] || echo "export FASH_DIRECTORY='$HOME/.2fash'" >> ~/.bashrc
	[[ $(grep -i 'source "$FASH_DIRECTORY/bin/bash/bash-init.sh"' "$HOME/.bashrc") ]] || echo '[[ -s "$FASH_DIRECTORY/bin/bash/bash-init.sh" ]] && source "$FASH_DIRECTORY/bin/bash/bash-init.sh"' >> "$HOME/.bashrc"
}

install_fash() {
	if [[ -d "$FASH_DIRECTORY_BIN" ]]; then
		echo -en "You already have 2fash installed. Do you really want to install again? (y/N): "
		read really

		[[ ! ${really} =~ [yY]|[yY][eE][sS] ]] && exit 0

		rm -rf "$FASH_DIRECTORY_BIN"
	fi

	mkdir -p "$FASH_DIRECTORY_BIN"

	install_bin
	install_fash_bash
}

check_deps
install_fash

exit 0