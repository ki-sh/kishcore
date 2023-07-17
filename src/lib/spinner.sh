#!/bin/bash

clear
spinner=(⠁ ⠂ ⠄ ⡀ ⢀ ⠠ ⠐ ⠈)

# cat <<EOF
# Hello.
# Thank you for trying this script out.
# I will now wait 10 seconds,
# but you will see a "spinner"
# as a visual for the user.
# EOF

function cursorBack() {
    # echo -en "\033[$1D"
    echo -ne "\r$i"
}

startspin() {
    spin &
    spinpid=$!
    # echo ' ' # attempt to shift cursor to next line. failed. hide it? see spinner 2 ref.
}
endspin() {
    kill $spinpid
    echo ""
}

example_use() {
    # spin & spinpid=$!
    startspin
    for i in $(seq 1 10); do
        sleep 1
    done
    endspin

    # kill $spinpid
}

spin() {
    while [ 1 ]; do
        for i in "${spinner[@]}"; do
            cursorBack
            sleep 0.2
        done
    done
    cursorBack
    cursorBack
    echo ''
}

# example_use
