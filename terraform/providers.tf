provider "infisical" {
  host = var.infisical_url
  auth = {
    universal = {
      client_id     = var.infisical_auth_client_id
      client_secret = var.infisical_auth_client_secret
    }
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
  api_token = data.infisical_secrets.environment.secrets[local.cloudflare_provider_api_token_infisical_secret_name].value
}
