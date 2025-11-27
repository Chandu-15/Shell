#!/bin/bash
USER_ID=$(id -u)

#check whether script is running under root access or not
if [ $USER_ID -ne 0 ]; then
   echo "ERROR:Please execute the script under root access"
   exit 1 # we are manually forcing to exit from execution if any error occured
fi

dnf install mysql -y
if [ $? -ne 0 ]; then
   echo "ERROR: Instally MYSQL is FAILURE"
   exit 1
else
   echo "Installing MYSQL is SUCCESS"
fi
