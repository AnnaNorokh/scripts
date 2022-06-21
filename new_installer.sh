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

if [ $# -lt 1 ]; then
    echo "No arguments were supplied" 

elif [ $# -eq 1 ]; then

  if [ "$1" = "-i" ]; then
    # install to ~/local 
    echo "empty"
  else
    echo "Wrong arguments was supplied"
  fi  

elif [ $# -eq 2 ]; then  
    
    if [ "$1" = "create" ]; then
        [ ! -d $2 ] && echo "Directory $2 does not  exists." && exit 1

        cd ~ && tar czf $(basename $2).tar.gz -C $2 . && cat ~/$(basename $2).tar.gz >> ~/ramp_up/new_installer.sh 
        rm ~/$(basename $2).tar.gz
            

    elif [ "$1" = "-i" ]; then
        #install to provided
        LENGTH=$(wc -l ~/ramp_up/new_installer.sh)
        MARK=$(cat ~/ramp_up/new_installer.sh | grep -na "archive$")
        echo $MARK
        START=${MARK:0:2}
        END=${LENGTH:0:2}
        RANGE=$((END-START+1))

        #rename archive1
        cat ~/ramp_up/new_installer.sh | tail -n $RANGE >> ~/archive.tar.gz 
        tar -xzf ~/archive.tar.gz -C ~/files 
        rm ~/archive.tar.gz 
        


    elif [ "$1" = "-u" ]; then
        # uninstall 
        [ ! -e ~/.my-settings-$2 ] && echo "Settings file for $2 does not exists. It was missed or the programm wasn\`t installed yet" && exit 1
        
        if [ -e ~/.my-settings-$2-old ]; then
            DIRPATH=`head -n 1 ~/.my-settings-$2`
            OLDDIRPATH=`head -n 1 ~/.my-settings-$2-old`
            rm -R $DIRPATH 
            rm -R $OLDDIRPATH
            rm ~/.my-settings-$2 ~/.my-settings-$2-old

        elif [ ! -e ~/.my-settings-$2-old ]; then
            DIRPATH=`head -n 1 ~/.my-settings-$2`
            rm -R $DIRPATH
            rm ~/.my-settings-$2
        fi

        echo "Successfully uninstalled"
    else 
        echo "Unresolved argument was supplied"
    fi

elif [ $# -gt 2 ]; then
    #TODO DIR with spaces
   echo "Too many arguments were supplied" 

fi


#archive
