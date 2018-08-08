#!/bin/bash

HINTS_DIR=${0%/*}/hints-data

declare -A HINTS_MAP

fetch_hints() {
    for hint_file in $HINTS_DIR/*; do
        HINTS_MAP[${hint_file##*/}]=$(cat $hint_file)
    done
}

print_usage() {
    echo "USAGE: ${0##*/} <hint_name>"
    echo ""
}

print_cmds() {
    echo "List of available hints:"
    for hint_file in $HINTS_DIR/*; do
        hint_name=${hint_file##*/};
        hint_desc=${HINTS_MAP[$hint_name]}
        printf "\t$hint_name - ${hint_desc%%$'\n'*}\n"
    done
}

fetch_hints;

if [ "$#" -eq 1 ] && [ -n "${HINTS_MAP[$1]}" ]; then
    printf "$1: "
    printf "${HINTS_MAP[$1]}\n"
else
    print_usage;
    print_cmds;
fi
