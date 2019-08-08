#! /bin/bash

set -eux

stack_name=$1
template_path=$2
parameters_path=$3

describe_change_set_command="$(aws cloudformation deploy \
  --template-file ${template_path} \
  --stack-name ${stack_name} \
  --no-execute-changeset \
  --no-fail-on-empty-changeset \
  --parameter-overrides $(cat ${parameters_path} | tr '\n' ' ') | \
  grep 'aws cloudformation describe-change-set' || true)"

if [ -n "$describe_change_set_command" ]
then
  ## Atlantisに対して`terraform plan`実行したと見せかける
  touch dummy.tfplan

  $describe_change_set_command
fi
