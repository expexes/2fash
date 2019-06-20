#!/usr/bin/env bash

[[ -z "$FASH_DIRECTORY" ]] && FASH_DIRECTORY="$HOME/.2fash"
[[ -z "$FASH_DIRECTORY_BIN" ]] && FASH_DIRECTORY_BIN="$FASH_DIRECTORY/bin"

2fash() {
	bash "$FASH_DIRECTORY_BIN/2fash" "$@"
}