#!/bin/bash

. "$(pwd)/spinner.sh"

# test success
spinner_start 'sleeping for 2 secs...'
sleep 2
spinner_stop $?

# test fail
spinner_start 'copying non-existen files...'
# use sleep to give spinner time to fork and run
# because cp fails instantly
sleep 1
cp 'file1' 'file2' > /dev/null 2>&1
spinner_stop $?
