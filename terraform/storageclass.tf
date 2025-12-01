module "storageclass" {
  depends_on = [
    data.kubernetes_namespace.namespace,
  ]
  count = var.enable_persistent_storage ? 1 : 0
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/zfs_storageclass?ref=main"

  name = "${data.kubernetes_namespace.namespace.metadata[0].name}-sc"
  zfs_pool_name = local.zfs_pool_name
  reclaim_policy = local.storage_class_reclaim_policy
}
