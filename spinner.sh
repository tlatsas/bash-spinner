#!/usr/bin/env bash

# St. Benno
#
# @project    BashSpinner
# @author     Tasos Latsas
# @author     André Lademann <andre.lademann@netresearch.de>
# @link       http://fitnr.com/showing-a-bash-spinner.html
# @example
#   1. source this script in your's
#   2. start the spinner:
#       spinner_start [display-message-here]
#   3. run your command
#   4. stop the spinner:
#       spinner_stop [your command's exit status]
#
# Also see: test.sh

function _spinner() {

    # $1 start/stop
    #
    # on start: $2 display message
    # on stop : $2 process exit status
    #           $3 spinner function pid (supplied from spinner_stop)
    local on_success=" ok "
    local on_fail="fail"
    local white="\033[0;37m"
    local green="\033[01;32m"
    local red="\033[01;31m"
    local nc="\033[0m"

    case $1 in
        start)
            # Calculate the column where spinner and status msg will be displayed

            # Start spinner
            i=1
            sp='\|/-'
            delay=${SPINNER_DELAY:-0.15}

            # Display message and position the cursor in $column column
            while :
            do
                echo -en "\r[  ${sp:i++%${#sp}:1} ]  ${2}"
                sleep $delay
            done

            ;;
        stop)
            if [[ -z ${3} ]]; then
                echo -en "[${red}${on_fail}${nc}]  Spinner is not running."
                exit 1
            fi

            kill $3 > /dev/null 2>&1

            # Inform the user upon success or failure
            echo -en "\r["
            if [[ $2 -eq 0 ]]; then
                echo -en "${green}${on_success}${nc}"
            else
                echo -en "${red}${on_fail}${nc}"
            fi
            echo -e "]"
            ;;
        *)
            echo -en "[${red}${on_fail}${nc}]  Invalid argument, try {start/stop}"
            exit 1
            ;;
    esac
}

function spinner_start {
    # $1 : msg to display
    _spinner "start" "${1}" &
    # set global spinner pid
    _sp_pid=$!
    disown
}

function spinner_stop {
    # $1 : command exit status
    _spinner "stop" $1 $_sp_pid
    unset _sp_pid
}
