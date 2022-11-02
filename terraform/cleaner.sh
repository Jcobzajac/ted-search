#!/bin/bash

#This script allows us checking how long our environment (workspace) exist. Time is expressed in form of seconds

IFS=$'\n' read -d '' -r -a list_env < ./test_environments.txt

for element in "${list_env[@]}"
do
   #Declaration of variables
   name_env=$(echo $element | cut -d " " -f 1)
   created_time=$(echo $element | cut -d " " -f 2)
   current_time=$(echo $EPOCHSECONDS)

   #Computing lifespan of environment and checking whether environment exists more than 15 min
   lifespan=$((current_time-created_time))
   if [[ lifespan -gt 900 ]]
   then
     terraform workspace select $name_env
     terraform apply -destroy -auto-approve -var-file test.tfvars
     terraform workspace select prod
     terraform workspace delete $name_env
   else
     echo Environment $name_env exists less than 15 min
   fi
done
