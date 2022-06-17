#!/bin/bash
#


# unpack GCC 
mkdir gcc_sources && tar -xf gcc-11.1.0.tar.gz -C gcc_sources

#cp all .h  files to /my-headers
mkdir ~/my-headers && find gcc_sources -type f -name "*.h" | xargs cp -t my-headers/ 2>/dev/null

# look for files with .c extention and show first 20 strings with "_asm" word 
find gcc_sources -name "*.c" | xargs grep -E '_asm' | head -n 20 
