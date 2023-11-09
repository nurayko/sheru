#!/bin/bash

# Prints the path to the script file
# Usage: script_dir
function script_dir() {
    local dname="${0%/*}"
    dname="${dname#.}"
    printf "%s\n" "$PWD$dname"
}

# Prints the values of PATH variable new line each
# Usage: print_path
function print_path() {
    split "$PATH" ":"
    for path in "${_split[@]}"
    do
        printf "%s\n" "$path"
    done
    unset _split
}

# Prints the script name or the bash shell
# Usage: script_name
function script_name() {
    printf "%s\n" "${0##*/}"
}

script_name