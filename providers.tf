terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Helm Providers
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

# Kubectl Providers (required for kubectl_manifest)
provider "kubectl" {
  alias          = "cluster_1"
  config_path    = "~/.kube/config"
  config_context = "kind-rabbitmq-1"
}

provider "kubectl" {
  alias          = "cluster_2"
  config_path    = "~/.kube/config"
  config_context = "kind-rabbitmq-2"
}