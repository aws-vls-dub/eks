# Lab 8 - Working with namespaces

For this lab, you'll need to be in the `~/environment/eks/labs/08-namespaces` directory in Cloud9:

```bash
$ cd ~/environment/eks/labs/08-namespaces
```

## Define the namespaces

Check the namespace definition `namespaces.yaml` in the editor.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: prod
---
apiVersion: v1
kind: Namespace
metadata:
  name: dev
```

## Send this Definition to the Kubernetes Cluster

You'll be applying this namespace specification to the cluster via kubectl.

```bash
$ kubectl apply -f namespaces.yaml
namespace/prod created
namespace/dev created
```
- How can I list the namespaces ? 
- How can get all resouces configured in a given namespace ?

## Now let's create some objects using the imperative method

- Create a  pod in the prod namespace
```bash
$ kubectl run webapp-prod --image=nginx --restart=Never -n prod
```

- Create a pod in the dev namespace
```bash
$ kubectl run webapp-dev --image=nginx --restart=Never -n dev
```

- Create a service for the pod webapp-prod
```bash
$ kubectl expose pod webapp-prod --port=80 -n prod
service/webapp-prod exposed
```

- Create a service for the pod webapp-dev
```bash
$ kubectl expose pod webapp-dev --port=80 -n dev
service/webapp-dev exposed
```

- Connect to the service in both namespaces
```bash
kubectl run curl --image=radial/busyboxplus:curl -i --tty
nslookup webapp-dev
nslookup webapp-prod
```
- Were you able to connect ? Why ?

- Let's try creating the testing pod in each namespace
```bash
kubectl run curl --image=radial/busyboxplus:curl -i --tty -n dev
curl webapp-dev
kubectl run curl --image=radial/busyboxplus:curl -i --tty -n prod
curl webapp-prod
```

- What about now?

---

That's it for now. Once you're done you can take a look at some of the docs for namespaces in the Kubernetes documentation:

- [Kubernetes Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
- [Namespaces Walkthrough](https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough)
