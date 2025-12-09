terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    kubectl = {
      source = "alekc/kubectl"
      version = "~> 2.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 3.0"
    }
    jinja = {
      source = "NikolaLohinski/jinja"
      version = "~> 2.0"
    }
  }
}
