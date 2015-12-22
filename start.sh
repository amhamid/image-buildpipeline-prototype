#!/bin/bash

IMAGE_NAME=$1
IMAGE_TAG=$2

docker run -v /var/run/docker.sock:/run/docker.sock \
           -v $(which docker):/bin/docker \
           -v $(pwd):/project \
           -it buildstreet.local $IMAGE_NAME $IMAGE_TAG 