#!/bin/bash
docker push alexeymukhin/sample-node

ssh alexeymukhin@http://104.199.75.233/ << EOF
docker pull alexeymukhin/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi alexeymukhin/sample-node:current || true
docker tag alexeymukhin/sample-node:latest alexeymukhin/sample-node:current
docker run -d --restart always --name web -p 80:80 alexeymukhin/sample-node:current
EOF
