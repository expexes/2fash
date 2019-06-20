#!/usr/bin/env bash

__2fash_print_help_list() {
	echo ""
	__2fash_print_help_usage_head "${FASH_COMMAND} list [OPTION]..."
	echo ""
	__2fash_print_help_head "OPTIONS"
	__2fash_print_help_command "--help, -h" "show help"
	__2fash_print_help_command "--clear, -c" "clear format"
	echo ""
}

CLEAR_PRINT=0

for arg in "$@"; do
	case ${arg} in
		--clear|-c)
			CLEAR_PRINT=1
			shift			
			;;
		--help|-h)
			__2fash_print_help_list
			exit 0
			;;
	esac
done

accounts=$(find ${FASH_DIRECTORY_ACCOUNTS}/* -maxdepth 0 -type d -printf "%f\n")

for account in ${accounts}; do
	echo -en "$account"
	if [[ ${CLEAR_PRINT} == 0 ]]; then
		[[ $(__2fash_is_account_encrypted "$account") == 1 ]] &&
			echo -en " ${FORMAT_LGREEN}(encrypted)${FORMAT_NORM}" ||
			echo -en " ${FORMAT_LRED}(not encrypted)${FORMAT_NORM}"
	fi
	echo -e ""
done