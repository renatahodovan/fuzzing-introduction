#!/bin/bash -eu

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

$AFLPLUSPLUS_DIR/afl-plot \
	$WORK/afl/jerry_out/default \
	$WORK/afl/plot_out
