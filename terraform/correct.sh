#!/bin/bash

terraform output list-instances-ip-test
digit=$(terraform output amount-instances-test)
digit=1
#List IPs of test environmets
json=$(terraform output -json list-instances-ip-test | jq -r ".[$digit]")
echo $json

