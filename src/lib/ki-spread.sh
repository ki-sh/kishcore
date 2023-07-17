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
            file_dir_count+=1
        fi
    done

    # no params, or no files and no directories, default to current dir:
    if [ $# -eq 0 ] || [ $file_dir_count == 0 ]; then
        set "./"
    fi

    for p in "$@"; do

        if [ -d "$p" ]; then
            # log_info "has_target_files, process dir $p"
            local dir_stripped=${p/\/\//\/}
            # log_info "dir: $dir, stripped: $dir_stripped"
            res+="cd $dir_stripped,"
            res+="echo '',"
            res+="ey $dir_stripped:,"
            res+="$cmd ,"         # params if $@, shift dir
            res+="cd $returndir," #("cd ..") #

        fi
        if [ -f "$p" ]; then
        # some commands -git add yes you strange beast! need to cd to dir to assure works.
        # reliability over efficiency.
            file=$(basename "$p")
            dir=$(dirname "$p")
            res+="cd $dir,"
            res+="echo '',"
            res+="ey $dir:,"
            res+="$cmd $file,"    # params if $@, shift dir
            res+="cd $returndir," #("cd ..") #
            # res+="ey $p:,"
            # res+="$cmd $p,"
            # log_info "has_target_files -f $p"
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
