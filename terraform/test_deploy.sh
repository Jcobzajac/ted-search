#!/bin/bash

############### WELCOME ########################

# This script is used to create test environments and store data about them. By using this script you are able to provision infrastracture from
# your .tf files and store data about creation time of each environment. Each environment is saved in .txt file in format
# [environment-name] [time-of-creation-in-seconds]

#Checking whether I have any test environment
terraform workspace list > workspace_list.txt
is_test=$(cat workspace_list.txt | grep "test") 


if [[ $is_test = "" ]]  
then
  #Creating test workspace and assigning created time and name of environment
  terraform workspace new test
  echo test $EPOCHSECONDS > test_environments.txt
  echo $EPOCHSECONDS
  cat test_environments.txt
else
  #Counting amount of environmets in order to attach correct value to the environment
  counter=$(cat test_environments.txt | wc -l) 
  terraform workspace new test$counter
  echo test$counter $EPOCHSECONDS >> test_environments.txt
  echo $EPOCHSECONDS
  cat test_environments.txt
fi 


#Provisiong architecture and deploying application
  terraform init
  terraform apply -auto-approve -var-file test.tfvars -target=data.aws_instances.test
  terraform apply -auto-approve -var-file test.tfvars -target=data.aws_instances.general
  terraform apply -auto-approve -var-file test.tfvars
  sleep 15
  terraform refresh

#Script from user data (local variables) must be initialized and finished
sleep 30
#Computing index of EC2 instance 
digit=$(terraform output amount-instances-test)
((digit--))
#List IPs of test environmets
ip=$(terraform output -json list-instances-ip-test | jq -r ".[$digit]")

#Copying docker-compose file
scp -i "~/paris-zajac.pem" -o "StrictHostKeyChecking=no" docker-compose-test.yaml ubuntu@$ip:docker-compose-test.yaml
#Copying and executing the script to pull the latest images from ECR
scp -i "~/paris-zajac.pem" -o "StrictHostKeyChecking=no" pull_images_ecr.sh ubuntu@$ip:pull_images_ecr.sh
ssh -i "~/paris-zajac.pem" ubuntu@$ip "bash ./pull_images_ecr.sh -test"
ssh -i "~/paris-zajac.pem" ubuntu@$ip "mv docker-compose-test.yaml docker-compose.yaml" 
ssh -i "~/paris-zajac.pem" ubuntu@$ip "docker-compose up -d"

sleep 12

#E2E TESTING
chmod 700 E2E.sh
./E2E.sh $ip


