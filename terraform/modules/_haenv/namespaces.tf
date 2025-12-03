resource "kubernetes_namespace" "namespace" {
  count = var.create_namespace ? 1 : 0
  metadata {
    name = var.namespace
  }
}

data "kubernetes_namespace" "namespace" {
  depends_on = [
    kubernetes_namespace.namespace,
  ]
  metadata {
    name = var.namespace
  }
}
