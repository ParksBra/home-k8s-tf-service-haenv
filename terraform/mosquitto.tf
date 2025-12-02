module "mosquitto" {
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/mosquitto?ref=create_platform_tf"
  depends_on = [
    data.kubernetes_namespace.namespace
  ]

  chart_cleanup_on_fail           = var.chart_cleanup_on_fail
  chart_dependency_update         = var.chart_dependency_update
  chart_linting_enabled           = var.chart_linting_enabled
  chart_recreate_pods             = var.chart_recreate_pods
  chart_replace                   = var.chart_replace
  chart_upgrade_install           = var.chart_upgrade_install

  python_executable               = var.python_executable

  namespace                       = data.kubernetes_namespace.namespace.metadata[0].name
  create_namespace                = false

  data_persistence_enabled        = var.enable_persistent_storage
  data_volume_size_gb             = local.mosquitto_storage_size_gb
  data_storage_class_name         = var.enable_persistent_storage ? local.environment_storage_class_name : ""

  admin_username                  = var.mosquitto_admin_username
  admin_password                  = var.mosquitto_admin_password

  service_external_traffic_policy = "" # Empty string as defualt "CLuster" causes issues
}
