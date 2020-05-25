#!/bin/bash

# Install kubectl, eksctl, aws-iam-authenticator, create a key pair, and confirm the AWS CLI version

echo "Installing kubectl"

mkdir ~/bin
curl -so ~/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl
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

echo; echo "AWS identity:"

aws sts get-caller-identity | jq -r '.Arn'

echo; echo "You should expect to see the IAM Role we attached earlier, with an instance ID on the end"
echo; echo "For example: arn:aws:sts::1234567890:assumed-role/cloud9-AdminRole-1VFO62P60OPQ1/i-07dfdf99d48eb10b0"
