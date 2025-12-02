output "namespace" {
  description = "The Kubernetes namespace where the Home Assistant environment is deployed."
  value       = data.kubernetes_namespace.namespace.metadata[0].name
}

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

output "codeserver_enabled" {
  description = "Whether the Home Assistant Code Server is enabled."
  value       = var.codeserver_enabled
}

output "codeserver_service_address" {
  description = "The address of the Home Assistant Code Server service."
  value       = var.codeserver_enabled ? module.homeassistant.codeserver_service_address : ""
}

output "codeserver_service_port" {
  description = "The port of the Home Assistant Code Server service."
  value       = var.codeserver_enabled ? module.homeassistant.codeserver_service_port : null
}

output "codeserver_ingress_enabled" {
  description = "Whether ingress is enabled for the Home Assistant Code Server."
  value       = var.codeserver_enabled ? module.homeassistant.codeserver_ingress_enabled : false
}

output "codeserver_ingress_address" {
  description = "The ingress address of the Home Assistant Code Server."
  value       = var.codeserver_enabled ? module.homeassistant.codeserver_ingress_address : ""
}

output "mosquitto_enabled" {
  description = "Whether the Mosquitto MQTT broker is enabled."
  value       = var.mosquitto_enabled
}

output "mosquitto_service_address" {
  description = "The address of the Mosquitto service."
  value       = var.mosquitto_enabled ? module.mosquitto[0].service_address : ""
}

output "mosquitto_mqtt_port" {
  description = "The port of the Mosquitto service."
  value       = var.mosquitto_enabled ? module.mosquitto[0].service_mqtt_port : null
}

output "mosquitto_websocket_port" {
  description = "The WebSocket port of the Mosquitto service."
  value       = var.mosquitto_enabled ? module.mosquitto[0].service_websocket_port : null
}

output "mosquitto_admin_username" {
  description = "The admin username for the Mosquitto service."
  value       = var.mosquitto_enabled ? module.mosquitto[0].admin_username : ""
}

output "mosquitto_admin_password" {
  description = "The admin password for the Mosquitto service."
  value       = var.mosquitto_enabled ? module.mosquitto[0].admin_password : ""
  sensitive   = true
}

output "zigbee2mqtt_enabled" {
  description = "Whether Zigbee2MQTT is enabled."
  value       = var.zigbee2mqtt_enabled
}

output "zigbee2mqtt_service_address" {
  description = "The address of the Zigbee2MQTT service."
  value       = var.zigbee2mqtt_enabled ? module.zigbee2mqtt[0].service_address : ""
}

output "zigbee2mqtt_service_port" {
  description = "The port of the Zigbee2MQTT service."
  value       = var.zigbee2mqtt_enabled ? module.zigbee2mqtt[0].service_port : null
}

output "zigbee2mqtt_ingress_enabled" {
  description = "Whether ingress is enabled for the Zigbee2MQTT service."
  value       = var.zigbee2mqtt_enabled ? module.zigbee2mqtt[0].ingress_enabled : false
}

output "zigbee2mqtt_ingress_address" {
  description = "The ingress address of the Zigbee2MQTT service."
  value       = var.zigbee2mqtt_enabled ? module.zigbee2mqtt[0].ingress_address : ""
}

output "persistent_storage_enabled" {
  description = "Whether persistent storage is enabled for the Home Assistant environment."
  value       = var.enable_persistent_storage
}
