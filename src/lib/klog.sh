#!/bin/bash
source "$HOME/.kish/lib/colors.sh"

log_path="$HOME/.kishlog/"
cmd_logf="$log_path/cmd.log"
cmd_countf="$log_path/cmdcount.log"

function cmd_count_get() {
    echo $(cat "$cmd_countf")
}
function cmd_count_set() {
    echo "$1" >"$cmd_countf"
}

function cmd_count_increment() {
    local increment
    increment=$(($(cmd_count_get) + 1))
    cmd_count_set "$increment"
    if ((increment % 1000 == 0)); then

        b1='  ,-,-.   '
        b2=' / ( I \  '
        b3=' \ K ) /  '
        b4="  \`-'-'   "
        echo "${POWDER_BLUE}"
        echo "$b1"
        echo "$b2"
        echo "${YELLOW}$b3"
        echo "$b4"
        echo "${POWDER_BLUE}Awesome! You just used Ki Sh for the $increment'th time! "
        echo "How many countless coffee's has that saved you? "
        echo
        echo "Plenty! So buy me a coffee please to say thx, good Karma, ongoing dev."
        # echo "It takes a lot of coffee for us to create and maintain Kish."
        echo " Click link: ${GREEN}https://buymeacoffee.com/henryGuy "
        echo " ${NORMAL} Your support is massivly appreciated :)"
        echo "${NORMAL}"
    fi
}

if [[ ! -f "$cmd_countf" ]]; then
    cmd_count_set 0
fi

function klog() {
    echo "$@" >>"$cmd_logf"
    cmd_count_increment
}

function k_history() {
    echo "${YELLOW}ki log:${NORMAL}"
    cat "$cmd_logf"
}
