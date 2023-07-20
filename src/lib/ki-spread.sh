#!/bin/bash
: '
   No more cd!
   ki commands with ki-spread enabled:
   give directory(s) it visits them, and runs the command. 
   Can give file(s) or even a mixutre of file(s) and directory(s)
   Any args that are not a file/directory are applied.
   Args can be anwhere in the line - at the start,end or even middle.

'

source "$HOME/.kish/lib/colors.sh"
source "$HOME/.kish/lib/log.sh"
cmd=''
applicable='any'

function ey() {
    echo "${YELLOW}$*${NORMAL}"
}

function _ki-spread() {
    log_info "_ki-spread."
    local res=""
    local returndir=$PWD
    local file_dir_count=0

    for p in "$@"; do
        # not a file or directory,then args for cmd.
        if [ ! -e "$p" ]; then
            # if $p contains spaces quote it
            if [[ "$p" == *" "* ]]; then
                cmd+=' '
                cmd+=\"$p\"
            else
                cmd+=" $p"
            fi
        else
            file_dir_count=$(( $file_dir_count + 1 ))
        fi
    done

    # no params, or no files and no directories, default to current dir:
    log_info "file_dir_count: $file_dir_count"
    if [ $# -eq 0 ] || [ $file_dir_count -eq 0 ]; then
        log_info "setting ./" 
        set "./"
    fi

    for p in "$@"; do
        local file
        local dir
        if [ -e "$p" ]; then
            if [ -f "$p" ]; then
                file=$(basename "$p")
                dir=$(dirname "$p")
            else
                dir=$p
                file=''
            fi
            log_info "dir: $dir, file: $file"
            res+="cd $dir,"
            res+="echo '',"
            res+="ey $dir:,"
            res+="$cmd $file,"
            res+="cd $returndir,"

        fi

    done
    echo "$res"
}

# main operational entry point function.
# return commands to execute based on:
# is a single file?
# is multiple files (glob)
# child dirs. (with bubble up to parent)
# applicable
# workspace

function ki-spread() {
    # log_info "ks $PWD"
    res=$(_ki-spread "$@")
    IFS=','
    read -ra commands <<<"$res"
    IFS=' '
    for i in "${commands[@]}"; do
        #  todo -  drop evil eval.
        #   AT: EWWWW - YUK - -v double space. sort this out, horroribly fragile & DUP in ki_spread_dry
        [ "$i" = 'git add -v  ' ] && i="git add -v ." #specialy annoying edge case - ga requires params
        #  log_info "i: x-$i-y"
        eval "$i"
    done
}

# dry run - see output line by line without running it.
function ki_spread_dry() {
    #  log_info "ki_spread_dry $*"
    res=$(_ki-spread "$@")
    IFS=','
    read -ra commands <<<"$res"
    IFS=' '
    for i in "${commands[@]}"; do
        #   AT: EWWWW - YUK - -v double space. sort this out, horroribly fragile
        [ "$i" = 'git add -v  ' ] && i="git add -v ." #specialy annoying edge case - ga requires params
        # log_info "i: $i."
        echo "$i"
    done
}
