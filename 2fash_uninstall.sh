#!/usr/bin/env bash

for arg in $@; do
	case ${arg} in
		--no-ask-bin|-nab)
			__I_FASH_NO_ASK_BIN=true
			shift
		;;
		--no-delete-bin|-ndb)
			__I_FASH_NO_DELETE_BIN=true
			shift
		;;
		--no-ask-accounts|-naa)
			__I_FASH_NO_ASK_ACCOUNTS=true
			shift
		;;
		--no-delete-accounts|-nda)
			__I_FASH_NO_DELETE_ACCOUNTS=true
			shift
		;;
	esac
done

if [[ ${__I_FASH_NO_DELETE_BIN} != true ]]; then
	if [[ ${__I_FASH_NO_ASK_BIN} != true ]]; then
		echo -en "Are you sure? (y/N): "
		read rusure
		[[ ! ${rusure} =~ [yY]|[yY][eE][sS] ]] && exit 0
	fi

	echo "  ...deleting bin"
	rm -rf "${FASH_DIRECTORY}/bin"
	echo "  ...deleting fish support"
	rm -rf "$HOME/.config/fish/functions/2fash.fish"
	rm -rf "$HOME/.config/fish/completions/2fash.fish"
fi

if [[ ${__I_FASH_NO_DELETE_ACCOUNTS} != true ]]; then
	if [[ ${__I_FASH_NO_ASK_ACCOUNTS} != true ]]; then
		echo -en "Delete all accounts? (y/N): "
		read delallacc
		[[ ! ${delallacc} =~ [yY]|[yY][eE][sS] ]] && exit 0
	fi

	echo "  ...deleting accounts"
	rm -rf "${FASH_DIRECTORY}/accounts"
	rm -rf "${FASH_DIRECTORY}"
fi