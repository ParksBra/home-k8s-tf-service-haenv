variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
}

variable "python_executable" {
  description = "Path to the Python executable"
  type        = string
}

variable "azure_resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "azure_key_vault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}

variable "stack_lifecycle" {
  description = "The stack lifecycle stage (e.g., prod, dev, test)"
  type        = string
}
