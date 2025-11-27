#!/bin/bash
USER_ID=$(id -u)

#check whether script is running under root access or not
if [ $USER_ID -ne 0 ]; then
   echo "ERROR:Please execute the script under root access"
   exit 1 # we are manually forcing to exit from execution if any error occured
fi

VALIDATE(){ if [ $1 -ne 0 ]; then
   echo "ERROR: Instally $2 is FAILURE"
   exit 1
else
   echo "Installing $2 is SUCCESS"
fi
}
dnf install mysql -y
VALIDATE $? "mysql"

dnf install nginx -y
VALIDATE $? "nginx"

dnf install python3 -y
VALIDATE $? "python3"


