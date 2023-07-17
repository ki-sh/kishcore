#!/bin/bash
# shellcheck disable=SC2317  # Don't warn about unreachable commands in this file due to how kit works.
# shellcheck source=somefile
source "./$cmd.sh" # code under test

: '
   unit and E2E`ish tests with kish kit minimal testing framework
   eg kit ocal.test.sh
'

# turn off logging (comment out to turn back on)
log_info "log_info turned off in $cmd.test.sh"
log_info() {
    # noop
   return 0
}

# -------------- END HELPERS SECTION --------------------

# -------------- TESTS SECTION --------------------
desc "Description of upcoming tests..."

t() {
   input="myinput"
   fn=$($cmd $input)
   eq "($cmd $input). should... " "$fn" "now turn this expected green."
}
it t

