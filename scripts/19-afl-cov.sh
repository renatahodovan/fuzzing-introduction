#!/bin/bash -eu

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

if [ ! -d $WORK/afl/jerryscript_cov ]; then
	git clone --depth=1 https://github.com/jerryscript-project/jerryscript.git $WORK/afl/jerryscript_cov
fi

if [ ! -x $WORK/afl/jerryscript_cov/build/bin/jerry ]; then
    cd $WORK/afl/jerryscript_cov
    CC=gcc $AFL_COV_DIR/afl-cov-build.sh python3 tools/build.py \
        --logging=on \
        --strip=off \
        --clean \
        --compile-flag="-Wno-error" \
        --compile-flag="-Wno-enum-enum-conversion"
fi

cd $AFL_COV_DIR
./afl-cov \
    -d $WORK/afl/jerry_out \
    --coverage-cmd "$WORK/afl/jerryscript_cov/build/bin/jerry @@" \
    --code-dir $WORK/afl/jerryscript_cov \
    --cover-corpus \
    -O
