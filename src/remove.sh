#!/bin/bash

if [ "$1" = '-i' ]; then 
echo 
echo
# cat "$HOME/.kish/libs/ascii.txt"
echo
echo "This will REMOVE kish from: $HOME/.kish"
 read -r -p 'Do you want to continue? ' choice
    case "$choice" in
      n|N) echo 'quitting' && exit;;
      y|Y) 
      rm -rf ~/.kish/
      echo 'you should probably remove the line source ~./kish/aliases.sh from ~/.bashrc and or ~/.zshrc manually as well.' &&
       exit ;;
      *) echo 'Response not valid';;
    esac
else 
  # todo - nicer to delete files then dirs, so availiable in trash.
  rm -rf ~/.kish/
fi

