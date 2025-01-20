#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh


mkdir -p $WORK/grammarinator
if [ ! -f $WORK/grammarinator/CalculatorGenerator.py ]; then
    grammarinator-process Calculator.g4 -o $WORK/grammarinator
fi

grammarinator-generate \
    CalculatorGenerator.CalculatorGenerator \
    --sys-path $WORK/grammarinator \
    --rule expr \
    --stdout \
    --max-depth=10
