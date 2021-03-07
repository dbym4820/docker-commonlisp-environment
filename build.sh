#!/bin/sh

CDP=$(cd $(dirname $0); pwd)

# Build docker image
docker build -t simple-commonlisp-environment .

# Create docker container
#docker create -v "$CDP/commonlisp":/root/commonlisp -p 8888 -it --name simple-cl-env simple-commonlisp-environment:latest
docker rm simple-cl-env
docker create -v "$CDP/commonlisp":/root/commonlisp -p 5050:8888 -it --name simple-cl-env simple-commonlisp-environment:latest
