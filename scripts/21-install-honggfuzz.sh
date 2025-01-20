#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

cd $HONGGFUZZ_DIR
if [ ! -x $HONGGFUZZ_DIR/honggfuzz ]; then
    make
fi

if [ ! -d $HONGGFUZZ_DIR/honggfuzz/qemu_mode/honggfuzz-qemu ]; then
	cd qemu_mode
	make
	cd honggfuzz-qemu
	make
fi
