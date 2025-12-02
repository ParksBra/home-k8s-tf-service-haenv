module "zigbee2mqtt" {
  count = var.zigbee2mqtt_enabled ? 1 : 0
  source = "github.com/ParksBra/home-k8s-tf-lib//modules/zigbee2mqtt?ref=create_platform_tf"
  depends_on = [
    data.kubernetes_namespace.namespace,
    module.akri,
    data.kubernetes_resources.akri_udev_instances,
    module.mosquitto
  ]

  chart_cleanup_on_fail    = var.chart_cleanup_on_fail
  chart_dependency_update  = var.chart_dependency_update
  chart_linting_enabled    = var.chart_linting_enabled
  chart_recreate_pods      = var.chart_recreate_pods
  chart_replace            = var.chart_replace
  chart_upgrade_install    = var.chart_upgrade_install

  namespace                = data.kubernetes_namespace.namespace.metadata[0].name
  create_namespace         = false

  mqtt_broker_address      = local.mosquitto_mqtt_broker_address
  mqtt_broker_username     = module.mosquitto[0].admin_username
  mqtt_broker_password     = module.mosquitto[0].admin_password

  data_persistence_enabled = var.enable_persistent_storage
  data_volume_size_gb      = local.zigbee2mqtt_storage_size_gb
  data_storage_class_name  = var.enable_persistent_storage ? local.environment_storage_class_name : ""

  ingress_enabled          = true
  ingress_class_name       = local.environment_ingress_class_name
  ingress_host_address     = local.zigbee2mqtt_subdomain
  ingress_annotations      = local.environment_ingress_annotations

  pod_additional_resources = length(data.kubernetes_resources.akri_udev_instances.objects) > 0 ? {
    "${data.kubernetes_resources.akri_udev_instances.objects[0].spec.cdiName}" = "1"
  } : {}

  zigbee_serial_port       = length(data.kubernetes_resources.akri_udev_instances.objects) > 0 ? data.kubernetes_resources.akri_udev_instances.objects[0].spec.brokerProperties.UDEV_DEVNODE_0 : null
}
