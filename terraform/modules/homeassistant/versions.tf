terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
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

  required_version = "~> 1.14"
}

