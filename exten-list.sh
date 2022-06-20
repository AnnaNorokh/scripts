#!/bin/bash

# Description
# Prints all file extensions in current dir.

#find uniq file exentions in dir
find . -type f -name "?*.*" | egrep -i -o ".\w+$" | sort | uniq 
