# Lab 01 - Building & Running a Docker Image

For this lab, you'll need to be in the `~/environment/eks/labs/01-docker` directory in Cloud9:

```bash
$ cd ~/environment/eks/labs/01-docker
```

## Build image based on the Dockerfile

```bash
$ docker build -t python-app .
```

## Run container from the image

```bash
$ docker run -p 5000:5000 python-app
```
