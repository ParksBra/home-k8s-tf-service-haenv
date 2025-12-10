locals {
  environment_namespace = data.kubernetes_namespace.namespace.metadata[0].name
  environment_ingress_class_name = var.ingress_class_name
  environment_ingress_annotations = var.ingress_annotations
  homeassistant_subdomain = var.homeassistant_subdomain != null ? "${var.homeassistant_subdomain}.${var.environment_domain}" : var.environment_domain
  homeassistant_codeserver_subdomain = var.codeserver_enabled ? "${var.homeassistant_codeserver_subdomain}.${var.environment_domain}" : ""
  zigbee2mqtt_subdomain = var.zigbee2mqtt_enabled ? "${var.zigbee2mqtt_subdomain}.${var.environment_domain}" : ""

  environment_storage_class_name = var.storage_class_name
  homeassistant_storage_size_gb = var.homeassistant_storage_size_gb
  mosquitto_storage_size_gb = var.mosquitto_storage_size_gb
  zigbee2mqtt_storage_size_gb = var.zigbee2mqtt_storage_size_gb

  akri_udev_discovery_rules_list = [
    "SUBSYSTEM==\"${var.akri_udev_subsystem}\", ATTRS{idVendor}==\"${var.akri_zigbee_radio_vendor_id}\", ATTRS{idProduct}==\"${var.akri_zigbee_radio_product_id}\""
  ]
  akri_udev_serial_port = var.zigbee2mqtt_enabled && length(data.kubernetes_resources.akri_udev_instances[0].objects) > 0 ? data.kubernetes_resources.akri_udev_instances[0].objects[0].spec.brokerProperties.UDEV_DEVNODE_0 : null

  mosquitto_mqtt_broker_address = var.mosquitto_enabled ? "mqtt://${module.mosquitto[0].service_address}:${module.mosquitto[0].service_mqtt_port}" : ""

  zigbee2mqtt_adapter_type_map = {
    "0451" = "zstack"
    "10c4" = "ember"
    "1cf1" = "deconz"
    "1915" = "zboss"
  }
  zigbee2mqtt_adapter_type_default = null
  zigbee2mqtt_adapter_type = var.zigbee2mqtt_adapter_type_override != null ? var.zigbee2mqtt_adapter_type_override : lookup(local.zigbee2mqtt_adapter_type_map, lower(var.akri_zigbee_radio_vendor_id), local.zigbee2mqtt_adapter_type_default)
}
