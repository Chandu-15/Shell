#!/bin/bash
SOURCE_DIR=/home/ec2-user/app-logs
R="\e[31m"
N="\e[0m"

if [ ! -d $SOURCE_DIR ]; then
echo -e "$R ERROR...$SOURCE_DIR does not exists....$N"
exit 1
fi
FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath;
do
    echo "deleting the file"
    rm -rf $filepath
    echo "deleted the file"
done <<<$FILES_TO_DELETE