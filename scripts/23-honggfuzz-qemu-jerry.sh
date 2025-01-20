#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

echo "$JERRY_DIR/build/bin/jerry"
if [ ! -x $JERRY_DIR/build/bin/jerry ]; then
	CC=clang python3 $JERRY_DIR/tools/build.py \
  	  --debug \
   	  --logging=on \
   	  --clean \
      --compile-flag="-Wno-error" \
   	  --compile-flag="-Wno-enum-enum-conversion"
fi

cd $HONGGFUZZ_DIR
./honggfuzz \
	-i $ROOT/js_corpus \
	-o $WORK/honggfuzz/jerry_out \
	-- $HONGGFUZZ_DIR/qemu_mode/honggfuzz-qemu/x86_64-linux-user/qemu-x86_64 $JERRY_DIR/build/bin/jerry ___FILE___
