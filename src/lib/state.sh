#!/bin/bash

# state i/o in files.
# todo - refactor kit, klog to use. 
# not yet in use.
state_path="$HOME/.kish/temp/"

function state_init() {
  #   echo    "${YELLOW} state_init: $state_path$1"
  echo 0 >"$state_path$1"
}

# increment counter
function state_increment() {
  let kincrement=$(cat "$state_path$1")+1
  echo $kincrement >"$state_path$1"
}

# get id
function state_get() {
  echo $(cat "$state_path$1")
}

# set id value
function state_set() {
  echo $1 >"$state_path$1"
}