provider "azurerm" {
  features {
    key_vault {}
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "kubectl" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}

provider "jinja" {}

provider "cloudflare" {
  api_token = data.azurerm_key_vault_secret.cloudflare_provider_api_token.value
}
