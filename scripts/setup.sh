#!/bin/bash

export LC_ALL=C

export ROOT=$(dirname $(realpath $(dirname $0)))
export WORK=$ROOT/work
export THIRD_PARTY=$ROOT/third-party

export JERRY_DIR=$THIRD_PARTY/jerryscript
export RADAMSA_DIR=$THIRD_PARTY/radamsa
export GRAMMARINATOR_DIR=$THIRD_PARTY/grammarinator
export GRAMMARSV4_DIR=$THIRD_PARTY/grammars-v4
export CSMITH_DIR=$THIRD_PARTY/csmith
export AFLPLUSPLUS_DIR=$THIRD_PARTY/AFLplusplus

export JERRY_TREE_CORPUS=$WORK/grammarinator/jerry_tree_corpus
export JERRY_SRC_CORPUS=$WORK/jerry_src_corpus
export JS_SRC_CORPUS=$ROOT/js_corpus
export JS_TREE_CORPUS=$WORK/grammarinator/js_tree_corpus

export ASAN_OPTIONS+=":detect_odr_violation=0"

# sudo apt install python3.12-venv


if [ -z "${VIRTUAL_ENV:-}" ]; then
    if [ ! -d $WORK/.venv ]; then
        echo "Create virtualenv: $WORK/.venv"
        python3 -m venv $WORK/.venv
    fi
    echo "Enter venv $WORK/.venv"
    source $WORK/.venv/bin/activate
fi
