#!/usr/bin/env bash

__2fash_print_help_list() {
	echo ""
	__2fash_print_help_usage_head "${FASH_COMMAND} export <file.zip>"
	echo ""
}

if ! command -v zip &> /dev/null
then
    __2fash_echo_error "zip command could not be found"
    exit
fi

FILENAME="$2"

if [[ "$FILENAME" == "" ]]; then
  __2fash_print_help_list
  exit 0
fi

if [[ ! "$FILENAME" =~ \.zip$ ]]; then
  __2fash_echo_error "file \"$2\" doesn't end with .zip"
  exit 1
fi

if [[ -f "$FILENAME" ]]; then
  __2fash_echo_error "file \"$2\" already exists"
  exit 1
fi

if [[ ! -d "$FASH_DIRECTORY" ]]; then
  __2fash_echo_error "directory \"$FASH_DIRECTORY\" doesn't exist"
  exit 2
fi

CPWD="$PWD"
cd "$FASH_DIRECTORY"
if [[ "$FILENAME" =~ ^/ ]]; then
  zip -r -9 "$FILENAME" accounts
else
  zip -r -9 "$CPWD/$FILENAME" accounts
fi
cd - &> /dev/null

