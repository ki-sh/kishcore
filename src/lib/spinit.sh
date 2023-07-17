#!/bin/bash
# Shows a spinner while another command is running. Randomly picks one of 12 spinner styles.
# @args command to run (with any parameters) while showing a spinner.
#       E.g. ‹spinner sleep 10›
#  @see https://unix.stackexchange.com/questions/225179/display-spinner-while-waiting-for-some-process-to-finish

source ./spinner.sh

someaction() {
    startspin
    for i in $(seq 1 2); do
        sleep 1
    done
    endspin
}

someaction
