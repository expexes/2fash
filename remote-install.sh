#!/usr/bin/env bash

# -------------------------------------------------------

GIT_CLONE_REPO="https://gitlab.com/expexes/2fash"
GIT_CLONE_DESTINATION="/tmp/2fash-git-$(date | sed 's/ /_/g')"

# -------------------------------------------------------

if [[ -z $1 ]]; then
	git clone -b $1 "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" --single-branch && cd "$GIT_CLONE_DESTINATION" && basb install.sh
else
	git clone "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" && cd "$GIT_CLONE_DESTINATION" && bash install.sh
fi

rm -rf "$GIT_CLONE_DESTINATION"
