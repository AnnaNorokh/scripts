#!/bin/bash

# Author : Anna Norokh

# Description
# Script to install (reinstall and uninstall) directory. After installation there is tar.gz archive with installed dir 
# and my-settings file with paths to all installed files.

# Usage parameters 
# 
# -i /path                      install to /path
# -r /path                      reinstall to /path               
# -u program_name               uninstall dir
# -i                            install to  ~/local
# -r                            reinstall to ~/local  

if [ $# -lt 1 ]; then
    echo "No arguments were supplied" 

elif [ $# -eq 1 ]; then

  if [ "$1" = "-i" ]; then
        # install to ~/local 
        DIR=`pwd`
        DIRNAME=$(basename $DIR)      

        cd .. && SRCDIR=`pwd` && mv $DIR ~/local
        cd $SRCDIR && tar cvzf $DIRNAME.tar.gz ~/local/$DIRNAME > ~/.my-settings-$DIRNAME 

  elif [ "$1" = "-r" ]; then
        DIR=`pwd`
        DIRNAME=$(basename $DIR) 
        [ ! -e ~/.my-settings-$DIRNAME ] && echo "Settings file for $2 does not exists. It was missed or the programm wasn\`t installed yet" && exit 1
        [ ~/local/$DIRNAME/ == $DIR ] && echo "You are trying to reinstall to same dir" && exit 1
        
        LINE=`head -n 1 ~/.my-settings-$DIRNAME`
        OLDPATH=${LINE%?}

        if [ $DIR = $OLDPATH ]; then # если мы в директории первой установки скопировать файлы в новую директорию 
            mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
            cd .. && cp -r $DIR ~/local
            #cd ~/local && tar cvzf $DIRNAME.tar.gz ~/local/$DIRNAME > ~/.my-settings-$DIRNAME 
            echo "~/local/$DIRNAME/" > ~/.my-settings-$DIRNAME

        elif [ $DIR != $OLDPATH ]; then # eсли другая директория переместить в $2 и сохранить my-settings-old
            mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
            cd .. && SRCDIR=`pwd` && mv $DIR ~/local
            cd $SRCDIR && tar cvzf $DIRNAME.tar.gz ~/local/$DIRNAME > ~/.my-settings-$DIRNAME 
            echo "~/local/$DIRNAME/" > ~/.my-settings-$DIRNAME
        fi

  else
      echo "Wrong arguments was supplied"
  fi  

elif [ $# -eq 2 ]; then  
    if [ "$1" = "-i" ]; then
        # install to clients path 
        [ ! -d $2 ] && echo "Directory $2 does not exists." && exit 1
        DIR=`pwd`
        DIRNAME=$(basename $DIR)  
    
        cd .. && SRCDIR=`pwd` && mv $DIR $2
        cd $SRCDIR && tar cvzf $DIRNAME.tar.gz $2/$DIRNAME > ~/.my-settings-$DIRNAME 

    elif [ "$1" = "-r" ]; then
            
        DIR=`pwd`
        DIRNAME=$(basename $DIR)  
        
        [ ! -d $2 ] && echo "Directory $2 does not  exists." && exit 1
        [ ! -e ~/.my-settings-$DIRNAME ] && echo "Settings file for $2 does not exists. It was missed or the programm wasn\`t installed yet" && exit 1
        [ $2/$DIRNAME == $DIR ] && echo "You are trying to reinstall to same dir" && exit 1

        LINE=`head -n 1 ~/.my-settings-$DIRNAME`
        OLDPATH=${LINE%?}

        if [ $DIR = $OLDPATH ]; then # если мы в директории первой установки скопировать файлы в новую директорию 
            mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
            cd .. && cp -R $DIR $2
            #cd $DIR && tar cvzf $DIRNAME.tar.gz $2/$DIRNAME > ~/.my-settings-$DIRNAME
            echo "$2/$DIRNAME/" > ~/.my-settings-$DIRNAME

        elif [ $DIR != $OLDPATH ]; then # eсли другая директория переместить в $2 и сохранить my-settings-old
            mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
            cd .. && SRCDIR=`pwd` && mv $DIR $2
            #cd $SRCDIR && tar cvzf $DIRNAME.tar.gz $2/$DIRNAME > ~/.my-settings-$DIRNAME 
            echo "$2/$DIRNAME/" > ~/.my-settings-$DIRNAME
        fi
        
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

# test
