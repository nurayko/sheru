#!/bin/bash
# To make the functions available, source the file: source utils.sh

# Encode the input into base64
# Usage: encode input
function encode() {
    echo "$1" | base64
}

# Decode base64 input
# Usage: decode input
function decode() {
    echo "$1" | base64 -d
}