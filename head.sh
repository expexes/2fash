#!/bin/bash

if [ -z "$FASH_DIRECTORY" ]; then
    FASH_DIRECTORY="$HOME/.2fash"
fi

if [ -z "$FASH_DIRECTORY_BIN" ]; then
    FASH_DIRECTORY_BIN="$FASH_DIRECTORY/bin"
fi

if [ -z "$FASH_DIRECTORY_ACCOUNTS" ]; then
	FASH_DIRECTORY_ACCOUNTS="$FASH_DIRECTORY/accounts"
fi