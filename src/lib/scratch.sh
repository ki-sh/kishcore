#!/bin/bash
source "$HOME/.kish/lib/colors.sh"

# strip hidden chars (like colors from string)
# eg ansi_filter "$(tput setaf 9)foobar$(tput sgr0)"
ansi_filter() {
    local string
    string=$1
    string_sed="$(sed -r "s/\x1B\[[0-9;]*[JKmsu]//g" <<<"${string}")"
    echo "$string_sed"
}

ansi_filter "$(tput setaf 9)foobar$(tput sgr0)"

exit



shopt -s extglob # Enable Bash Extended Globbing expressions
xansi_filter() {

    #   local IFS=
    while read -r line || [[ "$1" ]]; do
        printf '%s\n' "${line//$'\e'[\[(]*([0-9;])[@-n]/}"
    done
}

input="${RED}XYZ abc DEF ${NORMAL}."
# res=$($input | sed 's/[^a-z  A-Z]//g')
# res=$(echo "$input" | tr -cd "[:print:]")
res=$(ansi_filter "$input")
echo "res: $res"

echo "len ${#input} "

# for i in ${input[@]}; do
# echo $i
# echo '.'
# done

exit 0

str=".//A"
stripper=${str/\/\//\/}
echo $stripper
