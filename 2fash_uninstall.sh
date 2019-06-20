#!/usr/bin/env bash

echo -en "Are you sure? (y/N): "
read rusure
[[ ! ${rusure} =~ [yY]|[yY][eE][sS] ]] && exit 0

rm -rf "${FASH_DIRECTORY}/bin"
rm -rf "$HOME/.config/fish/functions/2fash.fish"
rm -rf "$HOME/.config/fish/completions/2fash.fish"

echo -en "Delete all accounts? (y/N): "
read delallacc
[[ ! ${delallacc} =~ [yY]|[yY][eE][sS] ]] && exit 0

rm -rf "${FASH_DIRECTORY}/accounts"
rm -rf "${FASH_DIRECTORY}"