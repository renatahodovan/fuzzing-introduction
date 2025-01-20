#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

if [ ! -x $JERRY_DIR/build_hongg/bin/jerry ]; then
	CC=$HONGGFUZZ_DIR/hfuzz_cc/hfuzz-gcc python3 $JERRY_DIR/tools/build.py \
	    --debug \
	    --logging=on \
	    --clean \
	    --compile-flag="-Wno-error" \
	    --compile-flag="-Wno-enum-enum-conversion" \
	    --builddir=$JERRY_DIR/build_hongg
fi


cd $HONGGFUZZ_DIR
rm -rf $WORK/honggfuzz/jerry_out
mkdir -p $WORK/honggfuzz/jerry_out 
./honggfuzz \
	-i $ROOT/js_corpus \
	-o $WORK/honggfuzz/jerry_out \
	-- $JERRY_DIR/build_hongg/bin/jerry ___FILE___
