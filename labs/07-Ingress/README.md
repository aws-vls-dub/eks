# Lab 7 - Working with ALB Ingress Controller:

For this lab, you will need to ececute the script `~/environment/eks/labs/07-Ingress/configure-ingress.sh` to install ALB Ingress over your Cluster, you can check the AWS Docs here: https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html

## After Installing the the Ingres, you will be able to check a new pod on your cluster:

```bash
$ kubectl get pods -n kube-system
```


