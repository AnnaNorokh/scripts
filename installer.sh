#!/bin/bash

# Script for instalation files 
# Exapmle of use:
# ./installer.sh -i path        install current dir 
# ./installer.sh -u dir_name    uninstall dir
# ./installer.sh -r path        reinstall 

#  
# -i somepath   
# -r somepath                      удалять из старого места файлы?
# -u program_name 
# -i 
# -r 

#  взять файлы из папки -> скопировать все файлы в указанный путь -> записать все файлы -> собрать файлы в архив и удалить папку
#  взять папку -> скопировать(или мувнуть) папку в другое место -> создать архив -> листануть архив в файл 
#  


if [ $# -eq 2 ];  then

    if [ $1 = "install" ]; then
        # install to clients path 
        [ ! -d $2 ] && echo "Directory $2 does not exists." && exit 1
        DIR=`pwd`
        DIRNAME=${PWD##*/}     #??
    
        cd .. && SRCDIR=`pwd` && mv $DIR $2
        cd $SRCDIR && tar cvzf $DIRNAME.tar.gz $2/$DIRNAME > ~/.my-settings-$DIRNAME 
        #mv ~/my-settings-$DIRNAME ~/.my-settings-$DIRNAME

    elif [ $1 = "reinstall" ]; then
            # what if reinstal in current dir
            DIR=`pwd`
            DIRNAME=${PWD##*/}
            [ ! -d $2 ] && echo "Directory $2 does not  exists." && exit 1
            [ ! -e ~/.my-settings-$DIRNAME ] && echo "Settings file for $2 does not exists. It was missed or the programm wasn\`t installed yet" && exit 1
            
            LINE=`head -n 1 ~/.my-settings-$DIRNAME`
            OLDPATH=${LINE%?}

            if [ $DIR = $OLDPATH ]; then # если мы в директории первой установки скопировать файлы в новую директорию 
                mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
                cd .. && cp -R $DIR $2
                cd $2 && tar cvzf $DIRNAME.tar.gz $2/$DIRNAME > ~/.my-settings-$DIRNAME 

            elif [ $DIR != $OLDPATH ]; then # eсли другая директория переместить в $2 и сохранить my-settings-old
                mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
                cd .. && SRCDIR=`pwd` && mv $DIR $2
                cd $SRCDIR && tar cvzf $DIRNAME.tar.gz $2/$DIRNAME > ~/.my-settings-$DIRNAME 
            fi
        
    elif [ $1 = "uninstall" ]; then
        # uninstall 
        # TODO spaces in dir name
        [ ! -e ~/.my-settings-$2 ] && echo "Settings file for $2 does not exists. It was missed or the programm wasn\`t installed yet" && exit 1
        
        if [ -f ~/.my-settings-$2-old ]; then
            echo "OOps"
            DIRPATH=`head -n 1 ~/.my-settings-$2`
            OLDDIRPATH=`head -n 1 ~/.my-settings-$2-old`
            rm -R $DIRPATH
            rm -R $OLDDIRPATH
            rm ~/.my-settings-$2
            rm ~/.my-settings-$2-old

        elif [ ! -f ~/.my-settings-$2-old ]; then
            DIRPATH=`head -n 1 ~/.my-settings-$2`
            rm -R $DIRPATH
            rm ~/.my-settings-$2
        fi

        echo "Successfully uninstalled"

    else 
        echo "Unresolved argument was supplied"
    fi

elif [ $# -eq 1 ];  then

  if [ "$1" = "install" ]; then
        # install to ~/local 
        DIR=`pwd`
        DIRNAME=${PWD##*/}      

        cd .. && SRCDIR=`pwd` && mv $DIR ~/local
        cd $SRCDIR && tar cvzf $DIRNAME.tar.gz ~/local/$DIRNAME > ~/.my-settings-$DIRNAME 

  elif [ "$1" = "reinstall" ]; then
        DIR=`pwd`
        DIRNAME=${PWD##*/}
        [ ! -e ~/.my-settings-$DIRNAME ] && echo "Settings file for $2 does not exists. It was missed or the programm wasn\`t installed yet" && exit 1
        
        LINE=`head -n 1 ~/.my-settings-$DIRNAME`
        OLDPATH=${LINE%?}

        if [ $DIR = $OLDPATH ]; then # если мы в директории первой установки скопировать файлы в новую директорию 
            mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
            cd .. && cp $DIR ~/local
            cd ~/local && tar cvzf $DIRNAME.tar.gz ~/local/$DIRNAME > ~/.my-settings-$DIRNAME 

        elif [ $DIR != $OLDPATH ]; then # eсли другая директория переместить в $2 и сохранить my-settings-old
            mv ~/.my-settings-$DIRNAME ~/.my-settings-$DIRNAME-old
            cd .. && SRCDIR=`pwd` && mv $DIR ~/local
            cd $SRCDIR && tar cvzf $DIRNAME.tar.gz ~/local/$DIRNAME > ~/.my-settings-$DIRNAME 
        fi

  else
      echo "Wrong arguments was supplied"
  fi  

elif [ $# - gt 2 ]; then
    echo "Too many arguments was supplied"    
fi


