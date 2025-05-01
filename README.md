# checkmk

Demo - POC project for Checkmk interview

## Prerequisites
As a Cloud/Platform Engineer you want to write a small POC for your team in which you
showcase how you can deploy a Helm chart using Terraform in a multi-cluster setup. You
also want to showcase that you can connect from the internet to one of the services exposed
by your Helm chart.
Specs and further information:
- we recommend timeboxing your efforts to a maximum of 3 hours
- pseudo-code is acceptable; even if the code is not 100% we are still keen to see it
- do not worry about the Terraform backend
- if you struggle to choose a chart, you can pick the argoCD helm chart:
https://github.com/argoproj/argo-helm/tree/main/charts/argo-cd
- we are interested in how you structure and document your POC

## Infrastructure used
We could use a set of K8s clusters deployed on the Cloud like GKE to have a Cloud LoadBalancer automatically provisioned for us from the Cloud provider
to be able to have automatic access from the internet with an external-ip but given the simple usage of the POC I think
we can just use a couple of local K8s clusters deployed with Kind and expose the deployed service as NodePort and access it from localhost.

We can create a couple of K8s clusters locally with Kind in this way:

```
 kind create cluster --config ./config/kind-config.yaml --name rabbitmq-1
 kind create cluster --config ./config/kind-config-2.yaml --name rabbitmq-2
```

kind-config.yaml is just used to add an externalPortMapping to the kind clusters for port 31671/31672 that will be used to map RabbitMQ 15672 as NodePort

We could also simulate a LoadBalancer using tools like MetaLB: https://metallb.io/ or another similar solution and configure it with Kind to have an external-ip
but I'll leave it for this POC.

## Chart used

Bitnami offers a lot of Open Source helm charts released in a OCI format.
I have chosen to use RabbitMQ :)

There are two charts of RabbitMQ offered by Bitnami:
* RabbitMQ cluster operator: https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq-cluster-operator
* RabbitMQ: https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq

While the first one is the suggested one to use from the RabbitMQ team (as it is using the official RabbitMQ cluster operator),
I'll choose the second one as it more simple to install as it deployes directly the RabbitMQ service without using the operator so there are not two different components to manage by the
terraform script

## Terraform script

The terraform script is composed by different files:

* variables.tf: where there are some parameters we can modify to install the RabbitMQ clusters on a K8s cluster like the image, the repo, the name of the chart ecc ecc...
* providers.tf: the terraform providers mainly for helm
* main.tf: The main script which is installing the RabbitMQ cluster in the K8s clusters
* output.tf: Some outputs

## Limitations and Improvements

I would have liked to make the script to be more extensible like: writing the names of the K8s clusters as well as associate them with some RabbitMQ properties (username, password, ports to use ecc ecc...) in a configuration file and allow the script to loop over the K8s clusters and do the installation based on the RabbitMQ configurations
But because I don't know well Terraform or I hit some limitations I was taking too much time on this implementation and to be on the 3hours frame I decided to leave it for the moment.
As every project if useful also to have github action that on every PR and push on main run a deployment (for example on a kind cluster created inside a github vm) to validate for modifications. 

It is also better to develop RabbitMQ clusters on K8s using the cluster operator: 

https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq-cluster-operator

In this case the terraform script needs to take in consideration the installation of the operator and then of the RabbitMQ clusters

## How to test

on variables.tf we can override some parameteres (for example the namespace of the K8s cluster where the installation will take place like rabbitmq). We can also specify some specific parameters for the clusters.

on providers.tf there are the two helm provideres:

```
provider "helm" {
  alias = "cluster_1"
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-rabbitmq-1"
  }
}

provider "helm" {
  alias = "cluster_2"
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-rabbitmq-2"
  }
}
```
you need to modify the config_name specified in your ~/.kube/config

then you can:

```
terraform init
terraform plan
terraform apply
```

you can connect to a cluster and see if everything is up and running:

```
kubectl get all -n rabbitmq
```

you can then connect to the RabbitMQ UI using the port 31671/31672 (the same one used during the kind cluster creation and specified in the RabbitMQ variables.tf) from localhost

```
http://localhost:31671/
http://localhost:31672/
```





