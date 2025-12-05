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

data "azuredevops_variable_group" "library" {
  project_id = var.azuredevops_library_project_id
  name       = var.azuredevops_library_name
}
