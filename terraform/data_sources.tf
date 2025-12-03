data "infisical_secrets" "environment" {
  env_slug     = var.infisical_environment_slug
  workspace_id  = var.infisical_project_id
  folder_path  = "/"
}

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
