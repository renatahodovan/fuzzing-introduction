#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

if [ ! -f $AFLPLUSPLUS_DIR/custom_mutators/radamsa/radamsa-mutator.so ]; then
    cd $AFLPLUSPLUS_DIR/custom_mutators/radamsa/
    make
fi

unset ASAN_OPTIONS
#export AFL_CUSTOM_MUTATOR_ONLY=1
export AFL_CUSTOM_MUTATOR_LIBRARY=$AFLPLUSPLUS_DIR/custom_mutators/radamsa/radamsa-mutator.so
$AFLPLUSPLUS_DIR/afl-fuzz \
    -i $JS_SRC_CORPUS \
    -o $WORK/afl/jerry_radamsa_out \
    -t 1000 -- $JERRY_DIR/build_afl_persistent/bin/jerry-libfuzzer @@

#    -x $ROOT/js.dict \
