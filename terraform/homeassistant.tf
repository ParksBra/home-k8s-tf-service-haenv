module "homeassistant" {
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/homeassistant"
  version = "main"
  depends_on = [
    data.kubernetes_namespace.namespace,
    module.storageclass
  ]

  chart_cleanup_on_fail            = var.chart_cleanup_on_fail
  chart_dependency_update          = var.chart_dependency_update
  chart_linting_enabled            = var.chart_linting_enabled
  chart_recreate_pods              = var.chart_recreate_pods
  chart_replace                    = var.chart_replace
  chart_upgrade_install            = var.chart_upgrade_install

  namespace                        = data.kubernetes_namespace.namespace.metadata[0].name
  create_namespace                 = false

  ingress_enabled                  = true
  ingress_class_name               = local.environment_ingress_class_name
  ingress_host_address             = local.homeassistant_subdomain
  ingress_annotations              = local.environment_ingress_annotations

  force_configuration_init         = true # Always force init to ensure config changes are applied

  trusted_proxies                  = var.homeassistant_trusted_proxies

  pod_host_network_enabled         = true
  pod_dns_policy                   = "ClusterFirstWithHostNet"

  data_storage_persistence_enabled = var.enable_persistent_storage
  data_volume_size_gb              = local.homeassistant_storage_size_gb
  data_storage_class_name          = var.enable_persistent_storage ? module.storageclass[0].name : ""

  codeserver_enabled               = true
  codeserver_auth_enabled          = true
  codeserver_ingress_enabled       = true
  codeserver_ingress_host_address  = local.homeassistant_codeserver_subdomain
  codeserver_ingress_class_name    = local.environment_ingress_class_name
  codeserver_ingress_annotations   = local.environment_ingress_annotations
}
