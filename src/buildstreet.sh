#!/bin/bash

IMAGE_NAME=$1
IMAGE_TAG=$2

# do some static pre validation (by parsing Dockerfile or Packer conf)
../buildstreet/precondition.sh Dockerfile

# TODO: build a temporary Docker image (either using Dockerfile or packer json file)
docker build -t tmp_$IMAGE_NAME .

# finalize, post-validation, tag, and push image to registry
TMPDIR=~/tmp ../packer/packer build -var "image_name=$IMAGE_NAME" -var "image_tag=$IMAGE_TAG" ../buildstreet/packer.json
