#!/bin/sh

# Exit script on any error
set -e

# Always send ports different than 6379,6380,6381
# Add a valiadtion later
# Accept Redis master ports as arguments
MASTER1_PORT=$1
MASTER2_PORT=$2
MASTER3_PORT=$3

# Docker command to run Redis Stack Server cluster
docker run -d \
  -p ${MASTER1_PORT}:6379 \
  -p ${MASTER2_PORT}:6380 \
  -p ${MASTER3_PORT}:6381 \
  -p 6379:6379 \
  -p 6380:6380 \
  -p 6381:6381 \
  --name redis-cluster \
  aryaveerj/redis-stack-server-cluster:1.0.0
