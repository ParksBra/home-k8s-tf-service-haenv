data "kubernetes_config_map" "network_context" {
  metadata {
    name      = "context"
    namespace = "platform-network"
  }
}

data "kubernetes_config_map" "storage_context" {
  metadata {
    name      = "context"
    namespace = "platform-storage"
  }
}

data "azurerm_key_vault" "primary" {
  name                = var.azure_key_vault_name
  resource_group_name = var.azure_resource_group_name
}

data "azurerm_key_vault_secret" "cloudflare_provider_api_token" {
  name         = local.cloudflare_provider_api_token_secret_name
  key_vault_id = data.azurerm_key_vault.primary.id
}
