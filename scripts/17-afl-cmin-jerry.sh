#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh


$AFLPLUSPLUS_DIR/afl-cmin \
    -i $JERRY_SRC_CORPUS \
    -o $WORK/jerry_reduced_corpus \
    -t 1000 -- $JERRY_DIR/build_afl/bin/jerry @@
