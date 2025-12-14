app/

This application implements a lightweight Node.js REST API using Express and MongoDB. It establishes a MongoDB connection via Mongoose, defines a User schema with name and email fields, and exposes endpoints to create and retrieve user records. The service listens on a configurable port and returns JSON responses.

Docker Image Build

Build the Docker image using the image name specified in deployment.yaml:

docker build -t simple-node-mongo-app:prod .

Running with Minikube

To use a locally built Docker image with Minikube, configure the Docker environment before building the image:

Bash

eval $(minikube docker-env)


PowerShell

minikube docker-env | Invoke-Expression


Rebuild the image after setting the environment; otherwise, Minikube will not recognize the local image.

k8s/

The Node.js application and MongoDB are deployed to a Kubernetes cluster. Create the namespace first, then apply all Kubernetes manifests:

kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/

Minikube Ingress Setup

This setup has been tested with Minikube.

minikube addons enable ingress
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/
kubectl port-forward -n ingress-nginx svc/ingress-nginx-controller 8080:80


Access the application in a browser at:

http://localhost:8080

terraform/

Navigate to the terraform directory and run the following commands to initialize and validate the configuration:

terraform init
terraform validate
