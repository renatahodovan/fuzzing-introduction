#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh


if [ ! -x "$VIRTUAL_ENV/bin/grammarinator-process" ]; then
    cd $GRAMMARINATOR_DIR
    pip3 install -e .
    cd ..
fi
