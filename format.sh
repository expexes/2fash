FORMAT_NORM="\e[0m"
FORMAT_BOLD="\e[1m"
FROMAT_DIM="\e[2m"
FORMAT_INV="\e[7m"
FORMAT_RED="\e[31m"

echo_error() {
	echo -e "\n ${FORMAT_NORM}${FORMAT_RED}${FORMAT_BOLD}Error: ${FORMAT_NORM}${1}\n"
}