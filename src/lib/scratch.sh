#!/bin/bash
source "$HOME/.kish/lib/colors.sh"
source "$HOME/.kish/lib/log.sh"

full_path=/cas/43fg/temp/sample.txt
file=$(basename $full_path)
dir=$(dirname $full_path)
echo "dir $dir - $file"


exit


path=/aaa/bbb/ccc/ddd/eee/fff.txt
tail="${path#/*/*/}"
head="${path%/$tail}"
echo "$head" "$tail"

exit



p=$1

IFS='/'
read -ra slashsplit <<<"$p"
IFS=' '
# log_info "slashsplit: ${#slashsplit[@]}"
# if [ ${#dashsplit[@]} -eq 1 ]; then
#     file=$p
#     res+="ey $p:,"
#     res+="$cmd $p,"
# else
# navigate into dir and action cmd on file. (git add for example wont work if run from a dir outside of repo)
slashsplitlen=${#slashsplit[@]}
file=${slashsplit[$slashsplitlen]}
pathlen=$( slashsplitlen - 1 )
path="."


# for ((i = 0; i <= $slashsplitlen -1; i++)); do
#     if [[ i == "$slashsplitlen" ]]; then
#         file=${slashsplit[i]}
#     else
#         path+="/${slashsplit[i]}"
#     fi
# done

log_info "path: $path file: $file"


# ok this is a pain.
# might loop, if i == last, then assign as file.

log_info "file: $file, pathlen: $pathlen, slashsplitlen: $slashsplitlen "

exit


for ((i = 1; i <= pathlen; i++)); do
    path+="/$i"
done
res+="cd $path,"
res+="echo '',"
res+="ey $path:,"
res+="$cmd $file,"
res+="cd $returndir,"

# fi

exit

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
