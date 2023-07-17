#!/usr/bin/env bash

#  call this kit, move up a dir. add to geneated help.
#   calling kit runs all .test files.
#   parse file, search for onlyFname's, run only these tests. xeq
#   call this kit, move up a dir. add to geneated help.

source "$HOME/.kish/lib/colors.sh"
source "$HOME/.kish/lib/util.sh" # moved kstate here - do we need utils?
source "$HOME/.kish/lib/log.sh"
# States for global tracking :
#  kstate - test fail/pass counter
#  xstate - disable/enable test runs
#  TODO CHORE: refactor kstate and xstate to just state
kstate_path="$HOME/.kishlog/"
TP="testpass" #filename to log test passes
TF="testfail" #filename to log test fails
TS="tesskip"  #filename to log tesk skips (x/xoff)
xstate_path="$HOME/.kishlog/"
XSTATE_FILE="xstate" #filename to log xstate (on/off) for test run exclusion

# kstate_init id  sets to zero
function kstate_init() {
  #   echo    "${YELLOW} kstate_init: $kstate_path$1"
  echo 0 >"$kstate_path$1"
}

# increment counter
function kstate_increment() {
  let kincrement=$(cat "$kstate_path$1")+1
  echo $kincrement >"$kstate_path$1"
}

# get id
function kstate_get() {
  echo $(cat "$kstate_path$1")
}

# set id value
function kstate_set() {
  echo $1 >"$kstate_path$1"
}

# ------- xstate block start --------

#xreset id  sets to zero name:reset/init?
function xstate_init() {
  echo 0 >"$xstate_path$XSTATE_FILE"
}

# get xstate
function xstate_get() {
  echo $(cat "$xstate_path$XSTATE_FILE")
}

# set xstate value
function xstate_set() {
  echo $1 >"$xstate_path$XSTATE_FILE"
}
# -------xstate block end--------

kstate_init $TP
kstate_init $TF
kstate_init $TS
xstate_init

# turns off tests - eg: eq, desc
function xon() {
  xstate_set 1
}
# editors can upper case just x annoyingly
# function X () {
#   xstate_set 1
#  }

# turns back on (xstate=false) for eq, desc (if x previously called)
function xoff() {
  xstate_set 0
}

function xeq() {
  # noop
  kstate_increment "$TS"
  return 0 # ok
}

# only feature: if any oit in test source file switch to it to oit.
function it() {
  _it_enabled "$1"
}

function oit() {
  _it_enabled "$1"
}
function _fn_disabled() {
  return 0
}

function _it_enabled() {
  if [[ $(xstate_get) -eq 0 ]]; then
    eval "$1"
  else
    kstate_increment "$TS"
  fi
}

function xit() {
  kstate_increment "$TS"
}

function eq() {
  _eq_enabled "$@"
}
function oeq() {
  _eq_enabled "$@"
}

function _eq_enabled() {
  # xs=$(xstate_get)
  # log_info "eq xstate: $xs"
  # if [[ "$xs" -eq 0 ]]; then
  local testdesc="$1"
  local result="$2"
  local expected="$3" 


  echo "  $testdesc:"
  if [ "$result" == "$expected" ]; then
    kstate_increment "$TP"
    printf "${IGre}"
    echo "   √  $result."
    echo "   == $expected."
  else
    kstate_increment "$TF"
    # printf "${IRed}"
    echo "   ${RED}x${NORMAL}  $result."
    echo "   ${RED}!=${NORMAL} $expected."
    # echo "   != $expected."
  fi
  # reset color
  printf "${IWhi}\n"
  # fi
}

function desc() {
  [[ $(xstate_get) -eq 1 ]] && return 0
  # echo "------------------------ DESC -----------------------------------------------"
  #  printf ">>>>>>>>>>>> ${BIWhi} % ${IWhi} >>>>>>>>>>>> \n" "$1"

  printf "${BIWhi}"
  echo "$1"
  printf "${IWhi}"
  echo ""
}

# cd's to aliases (++ check current dir has any .test files first, if so run from there instead, fallback to configured dir.)
# search all .test files (++and sub dirs) ()
# parse test files searching for only/onlyeq? / onlyfrom tag.

# search all .test files (++and sub dirs) ()

: '
no params : default dir (aliases)
param : dir - *.test* within it.
param : one file - just that file
param : glob (multiple test files x*)

'

test_files=''
if (($# > 1)); then
  test_files="$@" #can test mutliple files.
else
  if [ -f "$1" ]; then
    test_files="$1"
    # log_info "test single file"
  else
    #if $1 dir
    if [ -d "$1" ]; then
      test_files="$1/*.test*"
    else
      test_files="$PWD/*.test*"
    fi
  fi
fi

# if (($# == 0)); then
#   test_files="$KISHDIR/aliases/*.test*"
#   cd $KISHDIR/aliases/
# fi

echo "test_files: $test_files"

for f in $test_files; do

  source_code=$(cat "$f")

  if [[ "$source_code" =~ .*oit*. ]]; then
    # echo 'oit:noop it!'
    function it() {
      _fn_disabled
    }
  fi

  if [[ "$source_code" =~ .*oeq*. ]]; then
    function eq() {
      _fn_disabled
    }
  # else
  #   function eq() {
  #     _eq_enabled "$@"
  #   }
  fi

  echo ""
  echo "-------------------------------- Test File: $f --------------------------------"
  #  () subshell: to improve tests isolation.  kstate to track passes/failed tests
  (
    source $f
  )
  echo ""
  # re-enable it for next test file.
  # todo - dry code. reference base it. fucking mutation of functions grrr - ok as long as code under 200 lines ;)
  function it() {
    _it_enabled "$1"
  }
done

testpasses=$(kstate_get "$TP")
testfails=$(kstate_get "$TF")
testskips=$(kstate_get "$TS")
((testcounter = testpasses + testfails))

echo "##################### Tests Done ######################"
echo ""
echo "${GREEN}$testpasses passed. ${RED} $testfails  failed. ${NORMAL} $testskips skipped. $testcounter tests ran."

xoff #turn x off for next test run.

# CI: 0: no errors; >0 erros. todo: TAP compliance.
# to figure out: return: can only `return' from a function or sourced script
# return  "$testfails"
