#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

# time for i in {1..1000}; do
while true; do
    len=$((RANDOM % 100 + 1))
    head /dev/urandom | tr -dc A-Za-z0-9 | head -c $len > test.js
    cat test.js
    $JERRY_DIR/build/bin/jerry test.js
done
