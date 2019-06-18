#!/usr/bin/env bash

source head.sh
source tools.sh

mkdir -p "$FASH_DIRECTORY"
mkdir -p "$FASH_DIRECTORY_BIN"
mkdir -p "$FASH_DIRECTORY_ACCOUNTS"

check_deps

echo "...moving bin to bin"
mv * .* "$FASH_DIRECTORY_BIN"

echo "...creating symbolic link in /usr/local/bin"
sudo ln -s "${FASH_DIRECTORY_BIN}/2fash" "/usr/local/bin/"