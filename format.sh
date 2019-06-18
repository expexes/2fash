FORMAT_NORM="\e[0m"
FORMAT_BOLD="\e[1m"
FROMAT_DIM="\e[2m"
FORMAT_INV="\e[7m"
FORMAT_RED="\e[31m"
FORMAT_LRED="\e[91m"
FORMAT_GREEN="\e[32m"
FORMAT_LGREEN="\e[92m"

echo_error() {
	echo -e "\n ${FORMAT_NORM}${FORMAT_RED}${FORMAT_BOLD}Error: ${FORMAT_NORM}${1}\n"
}

print_header() {
	echo ""
	echo -e "\t ____  _____ _    ____  _   _ "
	echo -e "\t|___ \|  ___/ _  / ___|| | | |"
	echo -e "\t  __) | |_ / _ _ \___ \| |_| |"
	echo -e "\t / __/|  _/ ___ _ ___) |  _  |"
	echo -e "\t|_____|_|/_/   \ _ ___/|_| |_|"
	echo ""
	echo ""
}

read_text_label_bold() {
	echo -en " ${FORMAT_NORM}${1}: ${FORMAT_BOLD}${2}"
}

read_text_label() {
	echo -en " ${FORMAT_NORM}${1}: ${2}${FORMAT_NORM}"
}