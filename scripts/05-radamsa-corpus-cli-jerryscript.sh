#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh

for file in $JS_SRC_CORPUS/*; do
  echo "Processing $file"
  cat $file
  echo
  cat "$file" | $RADAMSA_DIR/bin/radamsa -n 100 | while read -r line; do
    echo "$line" > test.js
    cat test.js
    $JERRY_DIR/build/bin/jerry test.js

    exit_code=$?
    case "$exit_code" in
        -11|-8|-6|-4|13|120|132|136|139|199)
          echo "Critical error detected (exit code: $exit_code)! Exiting script."
          exit 1
          ;;
        *)
    esac
  done || break
done
