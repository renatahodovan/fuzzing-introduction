#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

cd $AFLPLUSPLUS_DIR
CC=clang CXX=clang++ make
# make install
