#!/bin/bash

source head.sh
source format.sh
source tools.sh

print_help_list() {
	echo ""
	echo -e " ${FORMAT_BOLD}USAGE:${FORMAT_NORM} ./2fash list [OPTION]..."
	echo ""	
	echo -e " ${FORMAT_BOLD}OPTIONS:${FORMAT_NORM}"
	echo -e "\t--help, -h \t\t- show help"
	echo -e "\t--clear, -c \t\t- clear format"
}

CLEAR_PRINT=0

for arg in "$@"; do
	case $arg in
		--clear|-c)
			CLEAR_PRINT=1
			shift			
			;;
		--help|-h)
			print_help_list
			exit 0
			;;
	esac
done

accounts=$(find $FASH_DIRECTORY_ACCOUNTS/* -maxdepth 0 -type d -printf "%f\n")

for account in $accounts; do
	echo -en "$account"
	if [[ $CLEAR_PRINT == 0 ]]; then
		[[ $(is_account_encrypted "$account") == 1 ]] &&
			echo -en " ${FORMAT_LGREEN}(encrypted)${FORMAT_NORM}" ||
			echo -en " ${FORMAT_LRED}(not encrypted)${FORMAT_NORM}"
	fi
	echo -e ""
done