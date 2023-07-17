#!/bin/bash

# cd "$(dirname "$0")"
# source ./colors.sh
source "$HOME/.kish/lib/colors.sh"
source "$HOME/.kish/lib/log.sh"
st=''
cmd=''
applicable='any'
inapplicable='./node_modules'
mode=1 # 1: *dirs (/. to specify single) 2: single given dir.

function singleaction() {

    returndir=$PWD
    #  echo "action in $1"
    # todo: dry run: show what it would do, and ask confirm if any params are -dr
    # echo " cd $1 && $cmd $2 $3 $4 $5 $6 $7 $8 $9 "
    #  echo "$dir != $inapplicable ?"
    # if [ "$dir" != "$inapplicable" ]; then

    # single file aciton:

    # log_info "single action. $1 $returndir"

    if [ -f "$1" ]; then
        log_info "single action. on single file "
        $cmd $1
    else

        if [ -d "$1" ] && [ -e "$returndir" ]; then
            # log_info "cd to $1"
            cd "$1" || exit
        fi
        if [ "$dryrun" = true ]; then
            echo "$dr> $cmd $2 $3 $4 $5 $6 $7 $8 $9"
        else
            log_info "single action. mutiparams"
            if [ "$st" = 'gc' ]; then
                # quote wrap the message string
                $cmd "\"$2\"" $3 $4 $5 $6 $7 $8 $9
            else
                $cmd $2 $3 $4 $5 $6 $7 $8 $9

            fi
        fi
        [ -e "$returndir" ] && cd "$returndir" || exit
    fi
}

# multiaction :
# takes single directory,
# applies to  its child dirs first (if they pass applicable)
# if no children applicable, apply to the given single dir.
function multiaction() {
    if [ "$dryrun" = true ]; then
        printf "${IPur}"
        printf "$st: (%s*dirs) " "$1"
        [ "$applicable" != 'any' ] && printf " [%s]" "$applicable"
        printf " > "
        printf "${Whi}"
        printf "${IYel}"
        printf " %s" " $cmd"
        echo "$2 $3 $4 $5 $6 $7 $8 $9"
        printf "${Whi}"
    fi
    allowedcount=0
    for dir in $1/*; do # list directories in the form "/tmp/dirname/"
        if [ -d "$dir" ]; then
            # echo "$dir != $inapplicable ?"
            # if [ "$dir" != "$inapplicable" ]; then

            if [ "$applicable" = 'any' ] || [ -e "$dir/$applicable" ]; then
                printf "${IYel}"
                echo ''
                echo "$dir:"
                printf "${Whi}"
                singleaction $dir "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
                allowedcount+=1

                # todo: maybe enable with verbose option :
            else
                if [ "$dryrun" = true ]; then
                    printf "${IYel}"
                    echo ''
                    echo "$dir: excluded (has no $applicable)"
                    printf "${Whi}"
                fi
            fi
        # else - todo: verbose mode: say skipped as not an applicable git dir etc.
        fi

    done

    # if none of the children were allowable run for parent dir.
    #  So dont have to g targetdir/. - g targetdir will work.
    if [ "$allowedcount" = 0 ]; then
        # todo: verbose mode may show what was excluded and why
        # echo "debug: $allowedcount not zero"
        if [ "$applicable" = 'any' ] || [ -e "$1/$applicable" ]; then
            # printf "${IYel}"
            # echo ''
            # echo "$dir:"
            # printf "${Whi}"
            singleaction $1 "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
            allowedcount+=1
        fi

    fi
    if [ "$allowedcount" = 0 ]; then
        echo "No child or current dir with $applicable"
    fi
    allowedcount=0
    echo ''
}

# entry point.
# determines singe/multi action.
function action() {
    # echo "action $*"

    # mode 1: *dirs  2: single given dir.
    # if [ $mode = 2 ]; then
    #     singleki-spread "$@" && return
    # fi

    if [ "$dryrun" = true ]; then
        echo 'Dry Run: show effect, does not execute.'
    fi

    # prevent globbing patters
    if [ -d "$2" ] || [ -f "$2" ] && [ "$2" != '.' ]; then
        # special case for git add which needs a path specified.
        printf "2nd param was a file or directory. \n"
        printf "${Red}"
        printf "to use globbing (eg * /**/*) wrap the pathspec in quotes eg gs '*acme*' \n"
        printf "${Whi}"
        echo 'paramters recieved: '
        echo "$@"
        return
    fi
    # slashdot logic. allows forcing single action on current dir ignores applicables:
    # [[ $1 =~ /\. ]] && echo 'slash dot at end: /.'
    if [[ $1 =~ /\. ]] || [ "$1" = '.' ] || [ -f "$1" ]; then
        # printf "${IPur}"
        # echo "$st: $cmd  $1 $2 $3 $4 $5 $6 $7 $8 $9"
        # printf "${Whi}"
        singleki-spread "$@"
    else
        #  first param a directory (includes .)
        if [ -d "$1" ]; then
            multiki-spread "$@"
        else
            # eg gf -s  (defaults to execute for all children of .)
            # also for no params. workspace lookup prob goes here.
            # vscode workspace filtering: in working dir /bubble up folders
            strc="./.strc"
            # first check 1st param not a dir (move to check below **1)
            #  if [ -d "$1" ]; then
            if [[ -e "$strc" ]]; then
                # if active ws set, and found: $active_workspace
                source "$strc"
                # todo: if active_workspace set?
                if [ "$active_workspace" != 'nooperation' ] && [[ -e "$active_workspace" ]]; then
                    wsfolders=$(grep -o '"path": "[^"]*' "$active_workspace" | grep -o '[^"]*$')
                    # if one or more wsfolders:
                    if [ "${#wsfolders}" -gt 0 ]; then
                        printf "${Yel}"
                        echo "Filtered to workspace: $active_workspace:"
                        printf "${BYel}"
                        echo "$wsfolders"
                        printf "${Whi}"
                        echo ''

                        for a in $wsfolders; do
                            printf "${BYel}"
                            echo "$a"
                            printf "${Whi}"
                            multiki-spread "$a" "$@"
                        done
                        # multiki-spread "$wsfolders" "$@"

                        return
                    fi
                # else
                #     echo "$active_workspace file not found"
                fi
                # else
                #     # no params, no workspace filter:

            fi
            multiki-spread "." "$@"
        fi

    fi

}
