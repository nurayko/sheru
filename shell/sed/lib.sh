#!/bin/bash
# To make the functions available, source the file: source utils.sh

function __checkFileExists() {
    if [ ! -f "$1" ]
    then
        echo "Provided file $filename does not exist."
        return 1
    fi
}

function __checkNumberArgs() {
    if [ $1 -ne $2 ]
    then
        echo "Provided number of arguments $1 is not equal to desired $2."
        return 2
    fi
}

# Replace a pattern in a file.
# Usage: replaceAll filename pattern replacement
function replaceAll() {
    local filename="$1"
    local forReplacement="$2"
    local replacement="$3"

    __checkFileExists "$filename" || return

    __checkNumberArgs "$#" 3 || return

    sed -i "s|$forReplacement|$replacement|g" "$filename"
}

# Delete range of lines within a file, lower range is inclusive.
# Usage: deleteLines filename 5 10
function deleteLines() {
    local filename="$1"
    local lower_range="$2"
    local upper_range="$3"

    __checkFileExists "$filename" || return

    __checkNumberArgs "$#" 3 || return

    sed -i "$lower_range,${upper_range}d" "$filename"
}

# Prints range of lines within a file
# Usage: printLines filename 1 10 will print the first 10 lines of a file
function printLines() {
    local filename="$1"
    local start=$2
    local finish=$3

    __checkFileExists "$filename" || return

    __checkNumberArgs "$#" 3 || return

    sed -n "$start,${finish}p" "$filename"
}