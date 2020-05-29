## AWS Engineering Learning Series - Project

<p align="center">
  <img src="./two-tier-application.png" />
</p>

### Objective

You need to put together a 2 tier weh application, hosted in Kubernetes. The
application consists of a frontend and a backend. You will need to deploy both
and test the connectivity between the two. The application needs to be highly
available & fault tolerant.


### Steps - Frontend

1. Download the source code and deploy to your Kubernetes cluster.

    1. You'll need a Docker Hub account, create one [here](https://hub.docker.com/signup) if you don't have one yet.
    2. If you need to run Docker commands we recommend doing it from the Cloud9 environment.
    3. Source code is available in the GitHub Repo under `project/frontend`.
    4. Use `awselscpt/frontend-base` (already in Docker Hub) as the base image.
    5. **Important** - the application is configured to listen on port `tcp/4567`

1. Make sure that the frontend is accessible from the internet

1. Test the connection to the frontend

1. Test the connection to the backend from the deployed app


### Steps - Backend

1. Deploy the following image to your cluster `awselscpt/backend` (in Docker Hub already)

1. Configure your frontend to connect to your backend

1. Re-test the connnection to the backend from the frontend app - make corrections as necessary.


### Bonus Tasks

Once you've completed the above tasks, try the following:

* Restrict the access to the frontend to a given IP address or range

* Put your image in Amazon ECR repository and update your K8s objects

* Configure the frontend to automatically scale based on CPU utilization

* Migrate to using an Application Load Balancer for the frontend service

* Configure health checks for the frontend and backend


### Submission

Please access the page: https://deploymentels.support.aws.dev/ and click at the `Submit Challenge` button.

1. Please Make sure that the image which you build can be accessed publicly. [ dockerhub public repo under your account]
2. If you sucessfully build the application, add the LoadBalancer URL in a file called url.txt , with the http url **ONLY**
3. Fill out the assesment in [assesment/](https://github.com/aws-vls-dub/eks/tree/master/project/assessment) and together with all the yaml files used to solve the problem and zip it and send to: `https://deploymentels.support.aws.dev/#uploadChallange`.
4. Make sure to zip all the files without upper dir e.g.: `zip -r 01JhonSnow.zip *`
Note:
- The zip file must be named as: `Name` + `Surname`.zip, e.g.: `01JhonSnow.zip`
- It will **ONLY** be allowed **zip** files


### Setup - EKS Cluster

If you haven't created a cluster you can do so by following the [setup guidelines](./setup.md).
