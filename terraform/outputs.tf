output "homeassistant_service_address" {
  description = "The address of the Home Assistant service."
  value       = module.homeassistant.service_address
}

output "homeassistant_service_port" {
  description = "The port of the Home Assistant service."
  value       = module.homeassistant.service_port
}

output "homeassistant_ingress_enabled" {
  description = "Whether ingress is enabled for the Home Assistant service."
  value       = module.homeassistant.ingress_enabled
}

output "homeassistant_ingress_address" {
  description = "The ingress address of the Home Assistant service."
  value       = module.homeassistant.ingress_address
}

output "mosquitto_service_address" {
  description = "The address of the Mosquitto service."
  value       = module.mosquitto.service_address
}

output "mosquitto_mqtt_port" {
  description = "The port of the Mosquitto service."
  value       = module.mosquitto.service_mqtt_port
}

output "mosquitto_websocket_port" {
  description = "The WebSocket port of the Mosquitto service."
  value       = module.mosquitto.service_websocket_port
}

output "mosquitto_admin_username" {
  description = "The admin username for the Mosquitto service."
  value       = module.mosquitto.admin_username
}

output "mosquitto_admin_password" {
  description = "The admin password for the Mosquitto service."
  value       = module.mosquitto.admin_password
  sensitive   = true
}

output "zigbee2mqtt_service_address" {
  description = "The address of the Zigbee2MQTT service."
  value       = module.zigbee2mqtt.service_address
}

output "zigbee2mqtt_service_port" {
  description = "The port of the Zigbee2MQTT service."
  value       = module.zigbee2mqtt.service_port
}

output "zigbee2mqtt_ingress_enabled" {
  description = "Whether ingress is enabled for the Zigbee2MQTT service."
  value       = module.zigbee2mqtt.ingress_enabled
}

output "zigbee2mqtt_ingress_address" {
  description = "The ingress address of the Zigbee2MQTT service."
  value       = module.zigbee2mqtt.ingress_address
}

output "persistent_storage_enabled" {
  description = "Whether persistent storage is enabled for the Home Assistant environment."
  value       = var.enable_persistent_storage
}

output "storageclass_id" {
  description = "The ID of the storage class used for persistent storage."
  value       = var.enable_persistent_storage ? module.storageclass[0].id : null
}
