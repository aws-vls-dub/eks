# Project Setup

You will need the following to be able to complete this project:

- A running EKS cluster
- At least 2 nodes registered to the cluster.

### Launcing an EKS Cluster

Launch your cluster from the Cloud9 environment by running the following `eksctl` command:

```bash
$ eksctl create cluster --version 1.14 --node-type t3.medium --name eks
```

### Ensure that you have nodes attached

If you scaled down your cluster on Day 2 you can scale up using `eksctl` as follows:

```bash
$ eksctl get clusters
$ eksctl get nodegroup --cluster eks
$ eksctl scale nodegroup --cluster=eks --nodes=2 ng-xxxxxxx
```