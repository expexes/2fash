#!/usr/bin/env bash

# -------------------------------------------------------

GIT_CLONE_REPO="https://gitlab.com/expexes/2fash"
GIT_CLONE_DESTINATION="/tmp/2fash-git-$(date | sed 's/ /_/g')"

# -------------------------------------------------------

git clone "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" && cd "$GIT_CLONE_DESTINATION" && bash install.sh

rm -rf -i "$GIT_CLONE_DESTINATION"