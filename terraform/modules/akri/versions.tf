terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "~> 3.0"
    }
    time = {
      source = "hashicorp/time"
      version = "~> 0.0"
    }
  }

  required_version = "~> 1.14"
}
