#!/bin/bash
#
#

# egrep 
# | послед или возможн паралел

#find uniq file exentions in dir
find . -type f -name "?*.*" | egrep -i -o ".\w+$" | sort | uniq 





