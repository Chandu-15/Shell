#!/bin/bash
USER_ID=$(id -u)
# giving colours as  per our wish 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
W="\e[0m"

#check whether script is running under root access or not
if [ $USER_ID -ne 0 ]; then
   echo -e " $R ERROR:Please execute the script under root access $N"
   exit 1 # we are manually forcing to exit from execution if any error occured
fi
#creating function for  validation once package installed 
VALIDATE(){ if [ $1 -ne 0 ]; then
   echo -e "ERROR....$R $2 is FAILURE $N"
   exit 1
else
   echo -e "$R $2 is SUCCESS $N"
fi
}
# check whether package is installed or not if installed please ignore else install the package
dnf list installed mysql
if [ $? -ne 0 ]; then
  dnf install mysql -y
  VALIDATE $? "installing mysql"
else
  echo -e "Mysql already exists....$Y Skipping $N"
fi

dnf list installed nginx
if [ $? -ne 0 ]; then
 dnf install nginx -y
 VALIDATE $? "nginx"
else
  echo -e "Nginx already exists....$Y Skipping $N"
fi

dnf list installed python3
if [ $? -ne 0 ]; then
 dnf install python3 -y
 VALIDATE $? "python3"
else
  echo  -e "Python3 already exists....$Y Skipping $N"
fi

