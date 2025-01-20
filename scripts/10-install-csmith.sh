#!/bin/bash -eu

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

#sudo apt install g++ cmake m4
cd $CSMITH_DIR
cmake \
    -DCMAKE_INSTALL_PREFIX=myinstall \
    -DCMAKE_C_FLAGS="-Wno-enum-constexpr-conversion" \
    -DCMAKE_CXX_FLAGS="-Wno-enum-constexpr-conversion" .
make
make install
