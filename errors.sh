#!/usr/bin/env bash

source tools.sh

throw_error_if_account_doesnt_exist() {
	[[ $(is_account_exists "$1") == "0" ]] && echo_error "account doesn't exist" && exit 10
}

throw_error_if_account_exists() {
	[[ $(is_account_exists "$1") == "1" ]] && echo_error "account already exist" && exit 11
}

throw_error_if_account_secret_doesnt_exist() {
	! [[ -f "$FASH_DIRECTORY_ACCOUNTS/$1/.secret" ]] && echo_error "secret file doesn't exist" && exit 12
}