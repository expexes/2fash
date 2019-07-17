#!/usr/bin/env bash

# -------------------------------------------------------

GIT_CLONE_REPO="https://gitlab.com/expexes/2fash"
GIT_CLONE_DESTINATION="/tmp/2fash-git-$(date | sed 's/ /_/g')"

# -------------------------------------------------------

__uninstall_2fash() {
	source "$FASH_DIRECTORY_BIN/2fash_uninstall.sh" "-nab -nda"
}

__check_2fash_updates() {
	exit 1
}

if [[ -z $1 ]]; then
	__check_2fash_updates "${1}"
	git clone -b $1 "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" --single-branch && cd "$GIT_CLONE_DESTINATION" && __uninstall_2fash && basb install.sh
else
	__check_2fash_updates "master"
	git clone "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" && cd "$GIT_CLONE_DESTINATION" && __uninstall_2fash && bash install.sh
fi

rm -rf "$GIT_CLONE_DESTINATION"
