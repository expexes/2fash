#!/usr/bin/env bash

source head.sh
source format.sh
source tools.sh
source errors.sh

ACCOUNT=""
ACCOUNT_DIRECTORY=""

NO_PROMPT=0

print_help_remove() {
	print_help_usage_head "${FASH_COMMAND} remove [ACCOUNT] [OPTION]..."
	echo ""
	print_help_head "OPTIONS"
	print_help_command "--help, -h" "show help"
	print_help_command "--no-prompt, -np" "delete without ask"
}


for arg in "$@"; do
	case ${arg} in
		--help|-h)
				echo ""
				print_help_remove
				exit 0
			;;
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
	
	if [[ ${NO_PROMPT} == 0 ]]; then
		echo -en "Do you really want to delete ${FORMAT_BOLD}${FORMAT_YELLOW}${ACCOUNT}${FORMAT_NORM} account? (y/N): "
		really="n"
		read really
		[[ "$really" != "y" && "$really" != "Y" ]] && exit 0
	fi
	
	rm -rf "$ACCOUNT_DIRECTORY" && echo "Deleted"
else
	echo ""
	print_help_remove
	exit 0
fi