#!/bin/bash

echo Deploying Cicddemo CICD Pipeline

# Create/Update the Cicddemo setup/dependencies stack. This is manually created and maintained, and requires elevated permissions. 

# The Prod 'Developer' role requires a specific service role for all CloudFormation operations.
if [[ $(aws sts get-caller-identity --query Arn --output text) =~ "475661607190:assumed-role/Developer/" ]]; then
  # Append the role-arn option to the positional parameters $@ passed to cloudformation deploy.
  set -- "$@" --role-arn "arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/admin/CloudFormationService"
fi

STACK_NAME=cicddemo-cicd
TEMPLATE_FILE=cicd/2-cicd/pipeline.template.yml

echo Validating cloudformation template...
aws cloudformation validate-template \
  --template-body file://${TEMPLATE_FILE} \
  | cat

echo Updating cloudformation stack...
aws cloudformation deploy \
  --stack-name $STACK_NAME \
  --template-file ${TEMPLATE_FILE} \
  --parameter-overrides GitHubBranch=main \
  --capabilities CAPABILITY_IAM \
  --tags "Owner"="darin@code.org"
  "$@"

echo Complete!
