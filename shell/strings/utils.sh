#!/bin/bash
# To make the functions available, source the file: source utils.sh

# Check if input is valid integer, result is returned as exit code of function
# Usage: valid_int 123
function valid_int(){
    case ${1#-} in
    *[!0-9]*) false;;
    esac
}

# Length of input
# Usage: length string >> 6
function length(){
    echo "${#1}"
}

# Substring of string given an offset starting from 0 and optionally length
# Usage: substring string 0 3 >> str or substring string 1 >> tring
function substring() {
    # input="$1"
    # offset=$2
    _length=$3
    _length=${_length:=$(length "$1")}
    printf "%s\n" "${1:$2:$_length}"
}

# Convert all input to uppercase
# Usage: to_uppercase input >> INPUT
function to_uppercase() {
    printf "%s\n" "${*^^}"
}

# Convert all input to lowercase
# Usage: to_lowercase INPUT >> input
function to_lowercase() {
    printf "%s\n" "${*,,}"
}

# Capitalizes given string
# Usage: capitalize input >> Input
function capitalize() {
    printf "%s\n" "${1^}"
}

# Lowercases first letter from input
# Usage: lower_first_letter Input >> input
function lower_first_letter() {
    printf "%s\n" "${1,}"
}

# Replace first occurence of pattern with replacement string
# Usage: astring a my >> mystring
function replace() {
    input="${1:? Input string must be provided}"
    pattern="${2:? Pattern must be provided}"
    replacement="${3:? String for replacement must be provided}"
    printf "%s\n" "${input/$pattern/$replacement}"
}

# Replace first occurence of pattern with replacement string
# Usage: astring a my >> mystring
function replaceAll() {
    input="${1:? Input string must be provided}"
    pattern="${2:? Pattern must be provided}"
    replacement="${3:? String for replacement must be provided}"
    printf "%s\n" "${input//$pattern/$replacement}"
}

# Get the first index of a string in a string
# Usage: index_of mystring t >> 3
function index_of() {
    case "$1" in
        *"$2"*)
        local substring="${1%%"$2"*}"
        local index="${#substring}"
        echo $index;;
        *) echo "";;
    esac
}

# Reverse a string
# Usage: reverse mystring >> gnirtsym
function reverse() {
    local var="$1"
    local result=""
    local tmp="$var"
    while [ -n "$tmp" ]
    do
        all_but_last="${tmp%?}"
        result="$result${tmp#$all_but_last}"
        tmp="${all_but_last}"
    done
    printf "%s\n" "$result"
}

# Split a string and add results in _split array
# Usage: split "this/is/a/string" "/" >> ${_split[*]} == this is a string
function split() {
    _split=()
    local input="${1:? String to be splitted must be provided}"
    local symbol="${2:? Symbol for splitting must be provided}"
    local index=0
    local word
    local len=$(length "$1")
    while true
    do
        index=$(index_of "$input" "$symbol")
        if [[ -z $index ]]
        then
            local length=$(length "$input")
            if [[ $len -ne $length ]]
            then
                if [[ ! -z "$input" ]]
                then
                    _split+=( "$input" )
                fi
            fi
            return
        fi
        word="$(substring "$input" 0 $index)"
        _split+=( "$word" )
        input="$(substring "$input" $((index + 1 )))"
        index=$(( $index + 1))
    done
}