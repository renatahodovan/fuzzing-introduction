#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

echo "if (1 + 2 < 10) console.log('hello')" \
    | $RADAMSA_DIR/bin/radamsa -n 100 \
    | tee /dev/stderr \
    | $JERRY_DIR/build/bin/jerry -
