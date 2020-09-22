#!/bin/bash

# Install kubectl, eksctl, aws-iam-authenticator, create a key pair, and confirm the AWS CLI version

echo "Installing kubectl"

mkdir ~/bin
curl -so ~/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl
chmod +x ~/bin/kubectl

kubectl version --short --client

echo "Installing eksctl"

curl -s --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C ~/bin

# Installing jq, it's overkill for the job, but useful elsewhere
sudo yum -q install jq -y

# Set region and setup CLI
REGION=$(curl --silent http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
aws configure set region $REGION

echo "Creating SSH Key Pair"

ssh-keygen -N "" -f ~/.ssh/id_rsa > /dev/null

# eksctl will use the default SSH key location
#aws ec2 import-key-pair --key-name "eks" --public-key-material file://~/.ssh/id_rsa.pub

# Clearing Cloud9 temporary credentials
rm -vf ~/.aws/credentials

echo "AWS CLI version:"

aws --version

echo; echo "Checking AWS identity:"

C9ROLE=$(aws iam list-roles | jq -r '.Roles[] | select(.RoleName|match("Cloud9-AdminRole-*")) | .RoleName')
ROLE=$(aws sts get-caller-identity | jq -r '.Arn')
INSTANCEID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
ACCOUNT=$(aws sts get-caller-identity --query Account --output text)
if [ $ROLE == "arn:aws:sts::$ACCOUNT:assumed-role/$C9ROLE/$INSTANCEID" ]
then
echo "Your AWS identity is correct"
else
echo "Please check the attached ROLE on C9"
fi
