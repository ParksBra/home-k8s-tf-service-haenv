data "terraform_remote_state" "platform_storage" {
  backend = "kubernetes"
  config = {
    secret_suffix = "platform_storage-${var.stack_lifecycle}"
  }
}

data "terraform_remote_state" "platform_network" {
  backend = "kubernetes"
  config = {
    namespace     = "terraform-platform_network-${var.stack_lifecycle}"
    secret_suffix = "platform_network-${var.stack_lifecycle}"
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
