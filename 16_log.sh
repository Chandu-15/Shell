#!/bin/bash
USER_ID=$(id -u)
# giving colours as  per our wish 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOG_FOLDER="/var/log/Shell"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
#creating log file by getting log path and script details and storing in variables
mkdir -p $LOG_FOLDER
echo "Script execution started at: $(date)" | tee -a $LOG_FILE

#check whether script is running under root access or not
if [ $USER_ID -ne 0 ]; then
   echo -e " $R ERROR:Please execute the script under root access $N" | tee -a $LOG_FILE
   exit 1 # we are manually forcing to exit from execution if any error occured
fi
#creating function for  validation once package installed 
VALIDATE(){ if [ $1 -ne 0 ]; then
   echo -e "ERROR....$R $2 is FAILURE $N" | tee -a $LOG_FILE
   exit 1
else
   echo -e "$R $2 is SUCCESS $N" | tee -a $LOG_FILE
fi
}
# check whether package is installed or not if installed please ignore else install the package
dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]; then
  dnf install mysql -y &>>$LOG_FILE
  VALIDATE $? "installing mysql" 
else
  echo -e "Mysql already exists....$Y Skipping $N" | tee -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]; then
 dnf install nginx -y &>>$LOG_FILE
 VALIDATE $? "nginx"
else
  echo -e "Nginx already exists....$Y Skipping $N" | tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE
if [ $? -ne 0 ]; then
 dnf install python3 -y &>>$LOG_FILE
 VALIDATE $? "python3"
else
  echo  -e "Python3 already exists....$Y Skipping $N" | tee -a $LOG_FILE
fi