### this is not the recomended way to add ingress controller permissions, however we proceed with the below to deploy ingress controller quickly, however the best way is by create service account for the ingress controller ##
curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/v1.1.8/docs/examples/iam-policy.json
policy=`aws iam create-policy \
    --policy-name ALBIngressControllerIAMPolicy \
    --policy-document file://iam-policy.json`

policyarn=`echo $policy | awk '{ print $9}' | cut -d "\"" -f 2 `
role=`aws iam list-roles | grep eksctl-eks-nodegroup-ng | grep RoleName | awk '{ print $2 }' | cut -d "\"" -f 2 | head -n 1`
aws iam attach-role-policy --policy-arn $policyarn --role-name $role

