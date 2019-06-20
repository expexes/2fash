#!/usr/bin/env bash

ACCOUNT=""
ACCOUNT_DIRECTORY=""

NO_PROMPT=0

__2fash_print_help_remove() {
	echo ""
	__2fash_print_help_usage_head "${FASH_COMMAND} remove [ACCOUNT] [OPTION]..."
	echo ""
	__2fash_print_help_head "OPTIONS"
	__2fash_print_help_command "--help, -h\t" "show help"
	__2fash_print_help_command "--no-prompt, -np" "delete without ask"
	echo ""
}


for arg in "$@"; do
	case ${arg} in
		--help|-h)
				__2fash_print_help_remove
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
	
	__2fash_throw_error_if_account_doesnt_exist "$ACCOUNT"
	
	if [[ ${NO_PROMPT} == 0 ]]; then
		echo -en "Do you really want to delete ${FORMAT_BOLD}${FORMAT_YELLOW}${ACCOUNT}${FORMAT_NORM} account? (y/N): "
		really="n"
		read really
		[[ "$really" != "y" && "$really" != "Y" ]] && exit 0
	fi
	
	rm -rf "$ACCOUNT_DIRECTORY" && echo "Deleted"
else
	__2fash_print_help_remove
	exit 0
fi