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
We could use a set of K8s clusters deployed on the Cloud like GKE to have automatic access to Load Balancer but given the simple usage of the POC 
we can just use a couple of local K8s clusters developed with Kind and expose the deployed service to be accessed locally.

We can create a couple of K8s clusters locally with Kind in this way:

'''
kind create cluster --name rabbitmq-1
kind create cluster --name rabbitmq-2
'''

We could also simulate a LoadBalancer using tools like MetaLB: https://metallb.io/ and configure it with Kind
but I'll leave it for this POC.

## Chart used

Bitnami offers a lot of Open Source helm charts offered in a OCI format.
I have chosen to use RabbitMQ.

There are two charts of RabbitMQ offered:
* RabbitMQ cluster operator: https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq-cluster-operator
* RabbitMQ: https://github.com/bitnami/charts/tree/main/bitnami/rabbitmq

While the first one is the suggested one to use from the RabbitMQ team (as it is using the official RabbitMQ cluster operator),
I'll choose the second one as it more simple to install as it develop directly the RabbitMQ service without using the operator so there are not two components to manage.


## Terraform script

The terraform script is composed by different files:

* variables.tf: where there are 



