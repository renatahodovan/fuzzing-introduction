#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
source $SCRIPT_DIR/setup.sh


if [ ! -f $WORK/grammarinator/JavaScriptGenerator.py ]; then
    grammarinator-process \
        $GRAMMARSV4_DIR/javascript/javascript/*.g4 \
        -o $WORK/grammarinator \
        --no-actions \
        -DsuperClass=Generator
fi

# if [ ! -d $JERRY_TREES ]; then
#     cd $GRAMMARSV4_DIR/javascript/javascript/
#     python3 Python3/transformGrammar.py
#     cd -
#     grammarinator-parse \
#         $GRAMMARSV4_DIR/javascript/javascript/JavaScript*.g4 $GRAMMARSV4_DIR/javascript/javascript/Python3/JavaScript*.py \
#         --tree-format flatbuffers \
#         -i $JERRY_SRC_CORPUS/* \
#         -o $JERRY_TREE_CORPUS
# fi

if [ ! -d $JS_TREE_CORPUS ]; then
    cd $GRAMMARSV4_DIR/javascript/javascript/
    python3 Python3/transformGrammar.py
    cd -
    grammarinator-parse \
        $GRAMMARSV4_DIR/javascript/javascript/JavaScript*.g4 $GRAMMARSV4_DIR/javascript/javascript/Python3/JavaScript*.py \
        --tree-format flatbuffers \
        -i $JS_SRC_CORPUS/* \
        -o $JS_TREE_CORPUS
fi

grammarinator-generate JavaScriptGenerator.JavaScriptGenerator \
    --sys-path $WORK/grammarinator \
    -r program \
    -o $WORK/grammarinator/js_out/%d.js \
    --max-depth 20 \
    --max-tokens 300 \
    -n 100 \
    -s grammarinator.runtime.simple_space_serializer \
    --tree-format flatbuffers \
    --population $JS_TREE_CORPUS


for file in $WORK/grammarinator/js_out/*; do
    echo "Executing $file"
    cat $file
    echo
    $JERRY_DIR/build/bin/jerry $file

    exit_code=$?
    case "$exit_code" in
        -11|-8|-6|-4|13|120|132|136|139|199)
            echo "Critical error detected (exit code: $exit_code)! Exiting script."
            exit 1
            ;;
        *)
    esac
done || break
