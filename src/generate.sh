#!/bin/bash

: '
    stgen - generate any custom shorttask.
    sets st,cmd, applicable, 
    creates boilerplate.
    pathing - dodgy.
    help - todo


'
cat "$HOME/.kish/lib/ascii.txt"

#  todo: assumes stgen run with dir to kish. (not src/kish/yadayada/blabla)
#  feel need a .strc or ~.kish pointer to st forked repo.
#  otherwise thinking about searching for it - but that seems wrong.
#  maybe offer a hint if not found.
aliasesdir="$PWD/aliases"

# cmd for documentation only
cmd="Wizzard to generate your own custom KI commands."

# echo "$cmd"
echo "What do you want to name it?  The command name: eg: gs (for git status)"
read command_name

# echo "Welcome ${command_name}!"
script_file="$aliasesdir/$command_name.sh"

#  todo: check if cmd already taken - shorttask or binary.
#  and warn - never override an existing command
#  might give option to check if 'name taken'
# check file not there already - if so inform - should remove/move/rename first. && exit.

# option to add dry run:
# echo "Make a Dry run version of $command_name ? (Y/N)"

# read make_dry_run
# if [ $make_dry_run = 'y' ] || [ $make_dry_run = 'Y' ]; then

#     drscript_file="$aliasesdir/${command_name}dr.sh"

#     # echo "drscript_file: $drscript_file"

#     echo '#!/bin/bash' >"$drscript_file"
#     echo 'dryrun=true' >>"$drscript_file"
#     echo "source $HOME/.kish/$command_name.sh " >>"$drscript_file"
# fi

echo "Enter what the command executes (eg git  status -s -b)"
read command_execute

# echo "Enter applicable (eg for a git command it would be .git)"
# read command_applicable

# echo $aliasesdir

echo '#!/bin/bash' >"$script_file"
echo 'source "$HOME/.kish/lib/ki-spread.sh"
source "$HOME/.kish/lib/klog.sh"' >>"$script_file"
echo 'source "$HOME/.kish/lib/colors.sh"' >>"$script_file"
echo '' >>$script_file

echo "st='$command_name'" >>"$script_file"
echo "cmd='$command_execute'" >>"$script_file"
echo "applicable='$command_applicable'" >>"$script_file"
echo ' ' >>"$script_file"

echo 'if [ "$1" = '-h' ]; then' >>"$script_file"
echo '"$command_name ( $command_execute)"' >>"$script_file"
echo ' exit' >>"$script_file"
echo 'fi' >>"$script_file"

# add help section. todo: multi-line (cat <<EOF EOF)
# if [ "$1" = '-h' ]; then
#     echo "ga ( $cmd)" &&
#         echo "shortcut script ~/.kish/gco.sh" &&
#         echo "ga  adds . on dirs which are git initialised (have .git folder)"
#     echo "dont add the extra dot yourself"
#     exit
# fi

echo 'Should this command be runnable in different folders/files? (y/n)'
read multi_capable
if [ $multi_capable = 'y' ] || [ $multi_capable = 'Y' ]; then
    # enquiring: gs, gb, l
    # enquring: push (but not obviously)
    # operational: ga, gco
    echo 'ki-spread "$@"' >>"$script_file"
else
    # eg creational: hcl, gcl
    # eg non fs operational: hrl
    echo '$cmd $*' >>"$script_file"
fi
# add help template.
echo 'klog "$cmd $*"' >>"$script_file"

#  todo: only want this if logic in code, not for standard wrapped ki command.
# echo "Generate test file?"
# read generate_test_file
# if [ $generate_test_file = 'y' ] || [ $generate_test_file = 'Y' ]; then
#     test_file="$aliasesdir/$command_name.test.sh"
# fi

echo " $command_name generated to file: $PWD/aliases/$script_file done."
echo 'a. type kiu to make availiable.'
echo 'b. Since creating a new command, need to restart terminal ( or source ~/.[profile]) ).'
echo ''
