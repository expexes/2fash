#!/bin/bash

if [ -z "$FASH_DIRECTORY" ]; then
    FASH_DIRECTORY="$HOME/.2fash"
fi

if [ -z "$FASH_DIRECTORY_BIN" ]; then
    FASH_DIRECTORY_BIN="$HOME/.2fash"
fi

if [ -z "$FASH_DIRECTORY_ACCOUNTS" ]; then
	FASH_DIRECTORY_ACCOUNTS="$TWOFA_DIRECTORY/labels"
fi

mkdir -p "$FASH_DIRECTORY"
mkdir -p "$FASH_DIRECTORY_BIN"
mkdir -p "$FASH_DIRECTORY_ACCOUNTS"