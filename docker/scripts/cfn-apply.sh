#! /bin/bash

set -eux

stack_name=$1
template_path=$2
parameters_path=$3

aws cloudformation deploy \
  --template-file ${template_path} \
  --stack-name ${stack_name} \
  --no-fail-on-empty-changeset \
  --parameter-overrides $(cat ${parameters_path} | tr '\n' ' ') || \
  (aws cloudformation describe-stack-events --stack-name ${stack_name} && false)