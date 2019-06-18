#!/bin/bash

source head.sh
source format.sh
source tools.sh
source errors.sh

ACCOUNT=""
ACCOUNT_DIRECTORY=""

NO_PROMPT=0

print_help_remove() {
	echo ""
	echo -e " ${FORMAT_BOLD}USAGE:${FORMAT_NORM} ./2fash remove [ACCOUNT] [OPTION]..."
	echo ""	
	echo -e " ${FORMAT_BOLD}OPTIONS:${FORMAT_NORM}"
	echo -e "\t--help, -h \t\t- show help"
	echo -e "\t--no-prompt, -np \t- delete without ask"
}


for arg in "$@"; do
	case $arg in
		-a=*)
			ACCOUNT="${arg#*=}"
			ACCOUNT_DIRECTORY="${FASH_DIRECTORY_ACCOUNTS}/${ACCOUNT}"
			shift
			;;
		--no-prompt|-np)
			NO_PROMPT=1
			shift
			;;
	esac
done

if [[ "$ACCOUNT" != "" ]]; then
	
	throw_error_if_account_doesnt_exist "$ACCOUNT"
	
	if [[ $NO_PROMPT == 0 ]]; then
		echo -en "Do you really want to delete ${FORMAT_BOLD}${FORMAT_LRED}${ACCOUNT}${FORMAT_NORM} account? (y/N): "
		REALLY="n"
		read REALLY
		[[ "$REALLY" != "y" && "$REALLY" != "Y" ]] && exit 0
	fi
	
	rm -rf "$ACCOUNT_DIRECTORY" && echo "Deleted"
else
	print_help_remove
fi