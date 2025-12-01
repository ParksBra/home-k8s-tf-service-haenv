module "storageclass" {
  depends_on = [
    data.kubernetes_namespace.namespace,
  ]
  count = var.enable_persistent_storage ? 1 : 0
  source = "../zfs_storageclass"

  name = "${data.kubernetes_namespace.namespace.metadata[0].name}-sc"
  zfs_pool_name = local.zfs_pool_name
  reclaim_policy = local.storage_class_reclaim_policy
}
