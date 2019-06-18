#!/usr/bin/env bash

source head.sh
source tools.sh

mkdir -p "$FASH_DIRECTORY"
mkdir -p "$FASH_DIRECTORY_BIN"
mkdir -p "$FASH_DIRECTORY_ACCOUNTS"

check_deps

echo "...moving bin to bin"
cp -a . "$FASH_DIRECTORY_BIN"

echo "...creating runnable in /usr/local/bin/2fash"
sudo echo "bash $FASH_DIRECTORY_BIN/2fash" > /usr/local/bin/2fash