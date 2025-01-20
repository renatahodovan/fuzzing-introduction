#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

if [ ! -x $JERRY_DIR/build_libfuzzer/bin/jerry-libfuzzer ]; then
    cd $JERRY_DIR
    CC=clang python3 tools/build.py \
     --logging=on \
     --debug \
     --compile-flag="-Wno-error" \
     --compile-flag="-Wno-enum-enum-conversion" \
     --libfuzzer=on \
     --builddir build_libfuzzer
fi

rm -rf $WORK/libfuzzer/jerry_input
mkdir -p $WORK/libfuzzer/jerry_input
cp $JS_SRC_CORPUS/* $WORK/libfuzzer/jerry_input

$JERRY_DIR/build_libfuzzer/bin/jerry-libfuzzer \
	$WORK/libfuzzer/jerry_input \
	-timeout=1000 \
	-artifact_prefix=$WORK/libfuzzer/artifacts/ \
	-create_missing_dirs=1

#    -dict=$ROOT/js.dict
