locals {
  environment_namespace = data.kubernetes_namespace.namespace.metadata[0].name
  environment_ingress_class_name = var.ingress_class_name
  environment_ingress_annotations = var.ingress_annotations
  parent_domain = var.parent_domain
  homeassistant_subdomain = "${var.homeassistant_subdomain}.${local.parent_domain}"
  homeassistant_codeserver_subdomain = "${var.homeassistant_codeserver_subdomain}.${local.homeassistant_subdomain}"
  zigbee2mqtt_subdomain = "${var.zigbee2mqtt_subdomain}.${local.parent_domain}"

  zfs_pool_name = var.zfs_pool_name
  storage_class_reclaim_policy = var.storage_class_reclaim_policy
  homeassistant_storage_size_gb = var.homeassistant_storage_size_gb
  mosquitto_storage_size_gb = var.mosquitto_storage_size_gb
  zigbee2mqtt_storage_size_gb = var.zigbee2mqtt_storage_size_gb

  akri_udev_discovery_rules_list = [
    "SUBSYSTEM==\"${var.akri_udev_subsystem}\", ATTRS{idVendor}==\"${var.akri_zigbee_radio_vendor_id}\", ATTRS{idProduct}==\"${var.akri_zigbee_radio_product_id}\""
  ]

  mosquitto_mqtt_broker_address = "mqtt://${module.mosquitto.service_address}:${module.mosquitto.service_mqtt_port}"

}
