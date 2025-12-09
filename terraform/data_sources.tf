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
