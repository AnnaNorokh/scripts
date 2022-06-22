#!/bin/bash

# Author : Anna Norokh

# Description
# Script to install (uninstall) directory. After creation there are archive at end of script.
# and my-settings file with paths to all installed files.

# Usage parameters 
# 
# create /dir/path              collect the source files from dir
# -i /path                      install to /path               
# -u program_name               uninstall dir
# -i                            install to  ~/local

#optional path

if [ $# -lt 1 ]; then
    echo "No arguments were supplied" 
elif [ $# -gt 2 ]; then
    #TODO DIR with spaces
   echo "Too many arguments were supplied" 

fi


if [ "$1" = "-c" ]; then
    [ ! -d $2 ] && echo "Directory $2 does not  exists." && exit 1

    echo $(basename $2) >> ~/ramp_up/new_installer.sh
    tar czf $(basename $2).tar.gz -C $2 . && cat ~/$(basename $2).tar.gz >> ~/ramp_up/new_installer.sh 
    rm $(basename $2).tar.gz  

elif [ "$1" = "-i" ]; then
    #install to provided
    END=$(cat  ~/ramp_up/new_installer.sh | wc -l)
    MARK=$(cat ~/ramp_up/new_installer.sh | grep -na "archive$")
    START=${MARK:0:2}   
    RANGE=$((END-START))
    NAME=$(sed -n "$((${START}+1))p" ~/ramp_up/new_installer.sh)

    if [ -f ~/.my-settings-$NAME ]; then 
        mv ~/.my-settings-$NAME  ~/.my-settings-$NAME-old
        echo "moved"
    elif [ -f ~/my-settings-$NAME-old ]; then
        echo "To be defined"
    fi

    if [ $# -eq 2 ]; then 
        cat ~/ramp_up/new_installer.sh | tail -n $RANGE >> ~/$NAME.tar.gz 
        mkdir -p $2/$NAME
        tar -xzf ~/$NAME.tar.gz -C $2/$NAME 
        rm ~/$NAME.tar.gz
        find $2/$NAME -maxdepth 1 -type f >> ~/.my-settings-$NAME

    elif [ $# -eq 1 ]; then
        cat ~/ramp_up/new_installer.sh | tail -n $RANGE >> ~/$NAME.tar.gz 
        mkdir -p ~/local/$NAME 
        tar -xzf ~/$NAME.tar.gz -C ~/local/$NAME 
        rm ~/$NAME.tar.gz
        find ~/local/$NAME -maxdepth 1 -type f >> ~/.my-settings-$NAME
    fi

elif [ "$1" = "-u" ]; then
    # uninstall 
    [ ! -f ~/.my-settings-$2 ] && echo "Settings file for $2 does not exists. It was missed or the programm wasn\`t installed yet" && exit 1
        
    if [ -f ~/.my-settings-$2-old ]; then
        while read line; do
            rm -r $line 
        done < ~/.my-settings-$2

        while read line; do
            rm -r $line 
        done < ~/.my-settings-$2-old

        rm ~/.my-settings-$2 
        rm ~/.my-settings-$2-old

    elif [ ! -f ~/.my-settings-$2-old ]; then
        while read line; do
            rm -r $line 
        done < ~/.my-settings-$2

        rm ~/.my-settings-$2
    fi
    
    echo "Successfully uninstalled"
else 
    echo "Unresolved argument was supplied"
fi

exit 0

#archive
