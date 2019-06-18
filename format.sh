FORMAT_NORM="\e[0m"
FORMAT_BOLD="\e[1m"
FROMAT_DIM="\e[2m"
FORMAT_INV="\e[7m"
FORMAT_RED="\e[31m"

echo_error() {
	echo -e "\n ${FORMAT_NORM}${FORMAT_RED}${FORMAT_BOLD}Error: ${FORMAT_NORM}${1}\n"
}

print_header() {
	echo ""
	echo -e "\t ____  _____ _"
	echo -e "\t|___ \|  ___/ _"
	echo -e "\t  __) | |_ / _ _"
	echo -e "\t / __/|  _/ ___ _"
	echo -e "\t|_____|_|/_/   \__"
	echo ""
	echo ""
}

check_deps() {
	if ! [ -x "$(command -v oathtool)" ]; then
		echo_error "intall oathtool"
		echo -e " Arch\t${FORMAT_BOLD}sudo pacman -S oath-toolkit${FORMAT_NORM}"
		echo -e " Fedora\t${FORMAT_BOLD}sudo dnf install oathtool${FORMAT_NORM}"
		echo -e " Ubuntu\t${FORMAT_BOLD}sudo apt install oathtool${FORMAT_NORM}"
		echo ""
		exit 2
	fi

	if ! [ -x "$(command -v gpg)" ]; then
		echo_error "intall gnupg"
		echo -e " Arch\t${FORMAT_BOLD}sudo pacman -S gnupg${FORMAT_NORM}"
		echo -e " Fedora\t${FORMAT_BOLD}sudo dnf install gnupg2${FORMAT_NORM}"
		echo -e " Ubuntu\t${FORMAT_BOLD}sudo apt install gpgv2${FORMAT_NORM}"
		echo ""
		exit 2
	fi
}