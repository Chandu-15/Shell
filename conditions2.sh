#!/bin/bash
num=$1

if [ $(($num % 2)) -eq 0 ]; then
  echo "Given $num is even number"
else
  echo "Given $num is odd number"
fi