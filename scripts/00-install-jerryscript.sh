#!/bin/bash -eu

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

cd $JERRY_DIR
CC=clang python3 tools/build.py \
    --debug \
    --logging=on \
    --clean \
    --compile-flag="-Wno-error" \
    --compile-flag="-Wno-enum-enum-conversion" \
    --compile-flag="-fsanitize=address"
