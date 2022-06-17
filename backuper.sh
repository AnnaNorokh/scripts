#!/bin/bash
#

BACKUP_DIR=~/backup
PROJ_DIR=~/ramp_up
NOW=$(date +'%Y-%m-%d_%H-%M-%S') 

if [ $# -eq 0 ] || [ $# -gt 2 ];  then
    echo "Wrong or any afguments was supplied"
    exit 9

elif [ $# -eq 1 ];  then

    if [ "$1" = "create" ]; then
        # create new .tar.gz from PROJ_DIR in BACKUP_DIR 
        cd ${PROJ_DIR} && cd ${BACKUP_DIR} && tar czf PROJ_${NOW}.tar.gz -C ${PROJ_DIR} .

    elif [ "$1" = "restore" ]; then
        echo "Second argument was not supplied"
        exit 9

    else
        echo "Unresolved argument was supplied"
        exit 9
    fi

elif [ $# -eq 2 ];  then
    
    find $BACKUP_DIR -type f -name "?*.tar.gz" | xargs basename -a -s .tar.gz >./archine_names.txt
    EXIST=false

    while read line; do
        [ "$2" == "$line" ] && EXIST=true
    done < ./archine_names.txt
    rm ./archine_names.txt

    if [ "$1" = "restore" ] && [ "$EXIST" == "true" ]; then
        # unpack selected archive to new folder ${PROJ_DIR}/archine_name
        mkdir ${PROJ_DIR}/$2 && cd ${BACKUP_DIR} && tar -xzf $2.tar.gz -C ${PROJ_DIR}/$2
    
    elif [ "$EXIST" == "false" ]; then
        echo "Backup archive with given name does not exist"
        exit 9
    fi
    
fi


