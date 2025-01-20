#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

mkdir -p $JERRY_SRC_CORPUS
find $JERRY_DIR/tests -name "*.js" -exec cp {} $JERRY_SRC_CORPUS \;
