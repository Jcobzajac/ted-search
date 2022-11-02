#!/bin/bash
sudo chmod 777 /var/run/docker.sock
aws ecr get-login-password --region ap-northeast-3 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com
docker pull 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com/jenkins-jz-pipe:nginxted$1
docker pull 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com/jenkins-jz-pipe:tedapp$1
