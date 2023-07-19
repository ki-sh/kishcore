#!/bin/bash

source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/colors.sh"

# todo:
# -ws pspec  : set active workspace file
# -wso pspec : set and code open it. meh
# -ws null   : show /return active ws file path.
# -wsx : unset vs ws.
# -h
#  none
function ki() {
    if [ "$1" = '-h' ] || [ $# = 0 ]; then
        echo ''
        echo ''
        cat "$HOME/.kish/lib/ascii.txt"
        # source "$HOME/.kish/lib/banner.sh"
        echo 'Help generated by $>kiu '
        echo ''
        echo '   short for     :      long              '
        echo '   ------------------------------------------------'
        cat "$HOME/.kish/lib/generatedhelp.txt" | tr -d '"' | tr -d "'"
        echo ''
        echo " Has Ki made you life easier? Paid forward: ${GREEN}https://buymeacoffee.com/henryGuy thx!"
        echo ''
    # cat "$HOME/.kish/lib/ki-spread.help.txt"

    # read -p "more..." </dev/tty

    # echo '$ gc "commit message"           - runs in every first level dir that is git enabled.'
    # echo '$ gc webapp "commit message"    - runs in webapp folder (as long as it is git enabled'
    # echo '$ gc . "commit message"         - runs in current folder.'
    # echo '$ gs                            - git status -s for every first level dir having package.json '
    else
        cmd=$1
        shift
        ki-spread "$@"
    fi
}
