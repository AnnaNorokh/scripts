#!/bin/bash
#

export BACKUP_DIR=~/backup
export PROJ_DIR=~/ramp_up
NOW=$(date +'%Y-%m-%d_%H-%M-%S') 

if [ $# -eq 0 ] || [ $# -gt 2 ];  then
    echo "Wrong afgument supplied"

elif [ $# -eq 1 ];  then

      [ "$1" = "restore" ]; echo "Second argument was not supplied"

      [ "$1" = "create" ]; cd ${PROJ_DIR} && cd ${BACKUP_DIR} && tar cvzf PROJ_${NOW}.tar.gz -C ${PROJ_DIR} . || echo "Unresolved argument was supplied"
    # if [ "$1" = "create" ]; then
    #     # create new .tar.gz from PROJ_DIR in BACKUP_DIR 
    #     cd ${PROJ_DIR} && cd ${BACKUP_DIR} && tar cvzf PROJ_${NOW}.tar.gz -C ${PROJ_DIR} .

    # elif [ "$1" = "restore" ]; then
          

    else
      echo "Unresolved argument was supplied"
    fi

elif [ $# -eq 2 ];  then

    if [ "$1" = "restore" ] && [ ! -z $2 ]; then
          # unpack selected archive to new folder ${PROJ_DIR}/archine_name
          mkdir ${PROJ_DIR}/$2 && cd ${BACKUP_DIR} && tar -xzvf $2.tar.gz -C ${PROJ_DIR}/$2
    
    else 
      echo "Unresolved argument was supplied"
    fi


fi










 # elif [ $# -gt 2 ];  then
#      echo "Too many arguments were supplied"