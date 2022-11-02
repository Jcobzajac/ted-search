#!/bin/bash 

aws ecr get-login-password --region ap-northeast-3 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com
#Pushing TEDSEARCH app as a tedapp / tedapp-test
docker tag spotify/foobar:1.1-SNAPSHOT 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com/jenkins-jz-pipe:tedapp$1
docker push 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com/jenkins-jz-pipe:tedapp$1
#Pushing NGINX image for TEDSEARCH as a nginxted / nginxted-test
docker tag nginxted 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com/jenkins-jz-pipe:nginxted$1
docker push 644435390668.dkr.ecr.ap-northeast-3.amazonaws.com/jenkins-jz-pipe:nginxted$1


