#!/bin/bash
num=$1
if [ $num -lt 10 ]; then
 echo "Given number $num is less than 10"
elif [ $num -gt 10 ]; then
 echo "Given number $num is greater than 10"
else
 echo "Given number is equal to 10"
fi