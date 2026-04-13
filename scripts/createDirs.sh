#!/bin/bash

filename="hosts.txt"
read -p "Enter host ssh password: " PASSWORD
export SSHPASS=$PASSWORD

while IFS= read -r line; do
  echo "editing $line"
  #sshpass -e scp -r ./search_me student@$line:/home/student/Desktop
  sshpass -e scp -o StrictHostKeyChecking=no -r ./search_me student@$line:/home/student/Desktop

done <"$filename"
