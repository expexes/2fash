#!/usr/bin/env bash

# -------------------------------------------------------

GIT_CLONE_REPO="https://gitlab.com/expexes/2fash"
GIT_CLONE_DESTINATION="/tmp/2fash-git-$(date | sed 's/ /_/g')"

# -------------------------------------------------------

__2fash_print_help_list() {
        echo ""
        __2fash_print_help_usage_head "${FASH_COMMAND} list [OPTION]..."
        echo ""
        __2fash_print_help_head "OPTIONS"
        __2fash_print_help_command "--help, -h" "show help"
        __2fash_print_help_command "--branch={}, -b={}" "install from specific branch"
        echo ""
}

CLEAR_PRINT=0

for arg in "$@"; do
        case ${arg} in
                --branch=*|-b=*)
                        __2fash_var_update_from_branch="${arg#*=}"
                        shift
                        ;;
                --help|-h)
                        __2fash_print_help_list
                        exit 0
                        ;;
        esac
done

__compare_2fash_versions() {
	test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"
}

__uninstall_2fash() {
	source "$FASH_DIRECTORY_BIN/2fash_uninstall.sh" "-nab -nda"
}

__check_2fash_updates() {
	__2fash_var_current_version="$(cat "${FASH_DIRECTORY_BIN}/VERSION")"
	__2fash_var_next_version="$(curl -s "${GIT_CLONE_REPO}/raw/${1}/VERSION")"

	! __compare_2fash_versions $__2fash_var_next_version $__2fash_var_current_version && echo "latest version already installed" && exit 1
	echo "  installing ${__2fash_next_version}"
}

if ! [[ -z $__2fash_var_update_from_branch ]]; then
	__check_2fash_updates "${__2fash_var_update_from_branch}"
	git clone -b $1 "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" --single-branch && cd "$GIT_CLONE_DESTINATION" && __uninstall_2fash && basb install.sh
else
	__check_2fash_updates "master"
	git clone "$GIT_CLONE_REPO" "$GIT_CLONE_DESTINATION" && cd "$GIT_CLONE_DESTINATION" && __uninstall_2fash && bash install.sh
fi

rm -rf "$GIT_CLONE_DESTINATION"
