terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2"
    }
    kubectl = {
      source = "alekc/kubectl"
      version = "~> 2"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 3"
    }
    jinja = {
      source = "NikolaLohinski/jinja"
      version = "~> 2"
    }
  }
}
