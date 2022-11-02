#!/bin/bash

#Provisiong the architecture for product environment / deployment of application to the production

terraform workspace list > workspace_list.txt

is_prod=$(cat workspace_list.txt | grep "prod")

if [[ $is_prod = "" ]]
then
  #Provisioning the production environment
  terraform workspace new prod
  terraform init
  terraform apply -auto-approve -var-file prod.tfvars #-lock=false
  sleep 15
  terraform apply -auto-approve -var-file prod.tfvars -target=data.aws_instances.prod
  terraform apply -auto-approve -var-file prod.tfvars -target=data.aws_instances.general
  #Script from user data (local variables) must be initialized and finished
  sleep 30
  #Assigning ip of this instance
  ip=$(terraform output -json list-instances-ip-prod | jq -r '.[0]')
  #Copying docker-composefile
  scp -i "~/paris-zajac.pem" -o "StrictHostKeyChecking=no" docker-compose.yaml ubuntu@$ip:docker-compose.yaml
  #Copying and executing the script to pull the latest images from ECR
  scp -i "~/paris-zajac.pem" -o "StrictHostKeyChecking=no" pull_images_ecr.sh ubuntu@$ip:pull_images_ecr.sh
  ssh -i "~/paris-zajac.pem" ubuntu@$ip "bash ./pull_images_ecr.sh"
  #Executing the docker-compose architecture
  ssh -i "~/paris-zajac.pem" ubuntu@$ip "docker-compose up -d"
else
  echo ellse
  #Redeploying newer version of our application
  ip=$(terraform output -json list-instances-ip-prod | jq -r '.[0]')
  ssh -i "~/paris-zajac.pem" ubuntu@$ip "docker-compose down"
  ssh -i "~/paris-zajac.pem" ubuntu@$ip "bash ./pull_images_ecr.sh"
  ssh -i "~/paris-zajac.pem" ubuntu@$ip "docker-compose up -d"
fi


