#!/bin/bash

url="$1"
tarcommand="$2"
dirname="$3"
delete_regex="$4"

if [ ! -d "$dirname" ]; then
    rm -rf $delete_regex
    wget -O- "$url" | tar "$tarcommand"
fi
