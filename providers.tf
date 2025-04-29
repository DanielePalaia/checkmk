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
    config_context = "kind-kind-rabbitmq-1"
  }
}

provider "helm" {
  alias = "cluster_2"
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-kind-rabbitmq-2"
  }
}