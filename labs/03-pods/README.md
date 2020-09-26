# Lab 3 - Introduction to Pods

For this lab, you'll need to be in the `~/environment/eks/labs/02-pods` directory in Cloud9:

```bash
$ cd ~/environment/eks/labs/02-pods
```

## Define a Pod

Check the pod definition `pod.yaml` in the editor.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-server
spec:
  containers:
    - name: server
      image: nginx
```

- What is the image that this pod is using, where will this image be pulled from?
- What will the name of this cluster be?


## Send this Definition to the Kubernetes Cluster

You'll be applying this pod specification to the cluster via kubectl.

```bash
$ kubectl apply -f pod.yaml
pod/web-server created
```


## List and Describe the Pod

Now you'll need to examine the pod:

```bash
# List the pods
$ kubectl get pods
NAME                              READY   STATUS    RESTARTS   AGE
web-server                        1/1     Running   0          10s

# Describe the details of the pod we just deployed
$ kubectl describe pod web-server
$ kubectl describe pod web-server
Name:               web-server
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               ip-10-0-100-30.eu-north-1.compute.internal/10.0.100.30
Start Time:         Fri, 27 Sep 2019 15:55:35 +0200
Labels:             <none>
[...]
```

- Take a look at the info that was returned from the describe call
- Which node is this pod deployed on?
- What happens if you do `kubectl get pods -o wide`?

## Access our Pod

Now you'll connect to the pod to see what a http call returns:

```bash
# Forward port 8080 locally to our deployed pod exposed on port 80
$ kubectl port-forward pod/web-server 8080:80 &

# Check what the response is when making a request to this pod
$ curl localhost:8080
```

- Take some time to appreciate what is happening here.
- How is this request locally being communicated to your pod?
    - Is the request going direct to the nodes?
    - Is the requset going via the API server?


## Clean Up

You ran port forward in the background. Now you'll need to close that connection:

```bash
# Bring back to the foreground
$ fg

# Hit Ctrl + C to kill the port forward
```

---

That's it for now. Once you're done you can take a look at some of the docs for pods in the Kubernetes documentation:

- [Kubernetes Pods](https://kubernetes.io/docs/concepts/workloads/pods/pod/)
- [Kubernetes Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/)
