# Lab 3 - Playing around with our Pod

For this lab, you should have already completed [Lab 1](./../02-pods/README.md).


## Check our Pod Logs

You can pull the logs for a pod:

```bash
$ kubectl logs web-server
```


## Execute commands inside our container

What is the hostname in our running pod:

```bash
# Perform a single command in our pod
$ kubectl exec -it web-server cat /etc/hostname

# Connect to a terminal inside our pod
$ kubectl exec -it web-server -- bash
```

## Delete the pods - DO NOT DO THIS YET

```bash
# Delete the pod
$ kubectl delete pod web-server

# Delete the pods as specified in the file
$ kubectl delete -f pods.yaml
```

---
