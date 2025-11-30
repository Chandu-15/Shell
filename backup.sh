#!/bin/bash
SOURCE=$1
DEST=$2
USERID=$(id -u)
DAYS=${3:-14}
if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege"
    exit 1 # failure is other than 0
fi

USAGE(){
    echo "sudo backup.sh source destination"
}
if [ $# -lt 2 ]; then
USAGE
exit 1
fi

if [ ! -d $SOURCE ]; then
  echo "ERROR...$SOURCE does not exists"
fi

if [ ! -d $DEST ]; then
  echo "ERROR...$DEST does not exists"
fi

file=$(find $SOURCE -name "*.log" -type f -mtime +$DAYS)

if [ ! -z "${file}" ]; then
    echo "archival-sucees"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_NAME="$DEST/app-logs-$TIMESTAMP.zip"
    find -$SOURCE -name "*.log" -type f -mtime +$DAYS | zip @ -j $ZIP_NAME

    if [ -f $ZIP_NAME ]; then
        while IFS = read -r filepath;
        do
        rm -rf $filepath
        done <<< $file
    else
     echo " archieval failure"
     exit 1
    fi

    else
 echo " skipping no  files to archieve"
fi 

