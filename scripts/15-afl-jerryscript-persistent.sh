#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

if [ ! -f $JERRY_DIR/build_afl_persistent/bin/jerry-libfuzzer ]; then
    cd $JERRY_DIR
    CC=$AFLPLUSPLUS_DIR/afl-clang-fast python3 tools/build.py \
    --libfuzzer=on \
    --logging=on \
    --debug \
    --compile-flag="-Wno-error" \
    --compile-flag="-Wno-enum-enum-conversion" \
    --clean \
    --builddir build_afl_persistent
    cd -
fi

unset ASAN_OPTIONS
$AFLPLUSPLUS_DIR/afl-fuzz \
    -i $JS_SRC_CORPUS \
    -o $WORK/afl/jerry_out \
    -t 1000 -- $JERRY_DIR/build_afl_persistent/bin/jerry-libfuzzer @@

#    -x $ROOT/js.dict \
