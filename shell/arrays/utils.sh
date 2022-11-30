#!/bin/bash

# Get the indexes of an array and store them in _get_indexes
# Usage: get_indexes array , indexes are stored in _get_indexes array
function get_indexes() {
    local array_name="${1:? Array name must be provided}"
    _get_indexes=()
    local command_text="for index in \"\${!$array_name[@]}\"; do _get_indexes+=( \"\$index\" ) ; done "
    eval "$command_text"
}

# Return the length of an array
# Usage: array_length array_name
function array_length() {
    local array_name="${1:? Array name must be provided}"
    local command_text="printf \"%d\n\" \${#$array_name[@]}"
    eval "$command_text"
}

# Check if element is contained in an array
# Usage: contains array_name element
function contains() {
    local array_name="${1:? Array name must be provided}"
    local element="${2:? Please provide element for search}"
    local _tmp_array
    eval "_tmp_array=( \"\${$array_name[@]}\" )"
    for item in "${_tmp_array[@]}"
    do
        if [[ "$item" == "$element" ]]
        then
            return 0
        fi
    done
    return 1
}

# Return count of element in an array
# Usage: element_count arrayname element
function element_count() {
    local array_name="${1:? Array name must be provided}"
    local element="${2:? Please provide element for search}"
    local _count=0
    local _tmp_array
    eval "_tmp_array=( \"\${$array_name[@]}\" )"
    for item in "${_tmp_array[@]}"
    do
        if [[ "$item" == "$element" ]]
        then
            _count=$(( $_count + 1 ))
        fi
    done
    printf "%d\n" $_count
}