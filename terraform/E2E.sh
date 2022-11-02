#!/bin/bash

#In order to use script provide text file with words, that will be used in sending requests


#Pulling all words from text file into array

IFS=$'\n' read -d '' -r -a tested_words < ./E2E.txt
 
digit=1

for element in "${tested_words[@]}"
do
  
  #Given timeout is for preventing from infinite loop in the case where we can't finish curl command
  
  timeout 25 curl -I http://$1:9191/api/search?q=$element
  
  if [ $? == 0 ]
  then
    echo Test $digit - Passed !
  else
    echo Test $digit - Failed! >&2 #Writing error message to the file descriptor number two (STDERR)
    exit 1
  fi
  ((digit++))
done
