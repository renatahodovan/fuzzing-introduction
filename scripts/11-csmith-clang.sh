#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

mkdir -p $WORK/csmith_tests/
mkdir -p $WORK/csmith_tests/compile_errors

for i in {1..100}; do
    test="$WORK/csmith_tests/$i.c"
    $CSMITH_DIR/src/csmith > $test
    output=$(clang -I$CSMITH_DIR/myinstall/include $test 2>&1)

    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo $output >> compile_errors/$i.log
    else
        echo "$i. test succeeded."
    fi
done
