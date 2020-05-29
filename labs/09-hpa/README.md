# Lab 9 - Working Horizontal Pod Autoscaler:

### For this lab, you will need to install metric server on your Cluster, for more information you can check the docs: https://docs.aws.amazon.com/eks/latest/userguide/horizontal-pod-autoscaler.html


1. Deploy the Metrics Server with the following command:
```bash
$ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
```

Verify that the metrics-server deployment is running the desired number of pods with the following command:
```bash
$ kubectl get deployment metrics-server -n kube-system
```

Output:
```
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
metrics-server   1/1     1            1           6m
```

2. After Installing the the metric-server, let's update the deployment from the previous lab, it was added the following lines:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: "2048-deployment"
  namespace: "2048-game"
spec:
  selector:
    matchLabels:
      app: "2048"
  replicas: 5
  template:
    metadata:
      labels:
        app: "2048"
    spec:
      containers:
      - image: alexwhen/docker-2048
        imagePullPolicy: Always
        name: "2048"
        ports:
        - containerPort: 80
*        resources:
*          limits:
*            cpu: 300m
*          requests:
*            cpu: 200m

```

3. Apply the new version:
```bash
$ kubectl apply -f 2048-deployment-hpa.yaml
```

4. Create a Horizontal Pod Autoscaler resource for the 2048 deployment.
```bash
kubectl autoscale deployment 2048-deployment -n 2048-game --cpu-percent=50 --min=1 --max=10
```

5. Describe the autoscaler with the following command to view its details.
```bash
kubectl describe hpa/2048-deployment -n 2048-game
```
Output:

```
Name:                                                  httpd
Namespace:                                             default
Labels:                                                <none>
Annotations:                                           <none>
CreationTimestamp:                                     Fri, 27 Sep 2019 13:32:15 -0700
Reference:                                             Deployment/httpd
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  1% (1m) / 50%
Min replicas:                                          1
Max replicas:                                          10
Deployment pods:                                       1 current / 1 desired
Conditions:
  Type            Status  Reason              Message
  ----            ------  ------              -------
  AbleToScale     True    ReadyForNewScale    recommended size matches current size
  ScalingActive   True    ValidMetricFound    the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  False   DesiredWithinRange  the desired count is within the acceptable range
Events:           <none>
```

As you can see, the current CPU load is only one percent, but the pod count is already at its lowest boundary (one), so it cannot scale in.

6. Create a load for the web server. The following command uses the Apache Bench program to send hundreds of thousands of requests. This should significantly increase the load and cause the autoscaler to scale out the deployment.
```bash
kubectl run apache-bench -i --tty --rm --image=httpd -- ab -n 500000 -c 1000 http://service-2048.2048-game.svc.cluster.local/
```

7. Open a new tab on your Cloud9 Environment and check the pod scaling with the command:
```bash
kubectl get horizontalpodautoscaler.autoscaling/2048-deployment -n 2048-game -w
```

Output:
```
NAME    REFERENCE          TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
2048-deployment   Deployment/httpd   76%/50%   1         10        10         4m50s
```
