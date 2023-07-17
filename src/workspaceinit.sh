#!/bin/bash

# Must be run from kish/. folder.

#  symlinks from ../ to all files in folders :
#  head-files: package.json

returndir=$PWD
dest='../'
# cd ..

#  todo: if already have files in root eg package.json, .tscrc .gitignore etc -
# offer to turn them into links ie - copy to head-files and linkback.
# the use case is - already setup for yarn workspaces.

preflight() {
    # prefilight checks
    okproceed=true
    for f in "$returndir"/head-files/*; do
        # link all files including hidden eg .lintrc
        if [[ -f "$dest/.${f##*/}" ]]; then
            echo "target file already exists: $dest/.${f##*/}"
            okproceed=false
        fi
    done
    for f in "$returndir"/head-dotfiles/*; do
        # link all files including hidden eg .lintrc
        if [[ -f "$dest/${f##*/}" ]]; then
            echo "target file already exists: $dest/${f##*/}"
            okproceed=false
        fi
    done

    if [ "$okproceed" == false ]; then
        echo "preflight checks fail. Initialisation  cancelled to prevent overwriting of target file(s)"
        exit
    else
        echo "preflight checks passed"
    fi
}

realpathfn() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

install() {
    echo 'st workspace init'
    echo 'Initialises repo container folder as yarn workspace with kish.'
    echo 'sym links to your kish forked repo files to have head folder files under source control.'
    echo 'Empowers sharing of multi-repos across teams/developers'
    echo 'Please note, you do not need to do this to use ST kish.'
    echo 'and all changes will be prompted.'
    echo "installs to: " 
    realpathfn $dest 

    read -p "continue..." </dev/tty
    # todo: ask if want apps, packages folders
    echo 'create apps and packages workspace folders? (y/n)'
    read make_folders
    if [ "$make_folders" == 'y' ] || [ "$make_folders" == 'Y' ]; then

        mkdir "$dest/apps"
        mkdir "$dest/packages"
    fi

    for f in "$returndir"/head-files/*; do
        # link all files unhidden files
        if [[ -f "$f" ]]; then
            # echo "linking: $f $dest${f##*/}"
            ln -s "$f" "$dest/${f##*/}"
        fi
    done

    # only difference is dot prefixed to filename
    for f in "$returndir"/head-dotfiles/*; do
        # link all files including hidden eg .lintrc
        if [[ ! -f "$dest/.${f##*/}" ]]; then
            echo "target file already exists: $dest/.${f##*/}"
        fi

        if [[ -f "$f" ]]; then
            # echo "linking: $f $dest${f##*/}"
            ln -s "$f" "$dest/.${f##*/}"
        fi
    done

    cd "$returndir" || exit
}

preflight
install
