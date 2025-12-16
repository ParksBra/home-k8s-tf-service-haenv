output "namespace" {
  description = "The name of the namespace in which Mosquitto is deployed."
  value       = data.kubernetes_namespace.namespace.metadata[0].name
}

output "chart_id" {
  description = "The Helm release ID for Mosquitto."
  value       = helm_release.application.id
}

output "chart_name" {
  description = "The Helm chart reference for Mosquitto."
  value       = helm_release.application.name
}

output "chart_reference" {
  description = "The Helm chart reference for Mosquitto."
  value       = local.chart_reference
}

output "service_address" {
  description = "The address of the Mosquitto service."
  value       = "${helm_release.application.name}.${data.kubernetes_namespace.namespace.metadata[0].name}.svc"
}

output "service_mqtt_port" {
  description = "The port of the Mosquitto MQTT service."
  value       = var.mqtt_port
}

output "service_websocket_port" {
  description = "The port of the Mosquitto WebSocket service."
  value       = var.websocket_port
}

output "mqtt_port" {
  description = "The MQTT port exposed by the Mosquitto service."
  value       = var.mqtt_port
}

output "websocket_port" {
  description = "The WebSocket port exposed by the Mosquitto service."
  value       = var.websocket_port
}

output "admin_username" {
  description = "The admin username for Mosquitto."
  value       = var.admin_username
}

output "admin_password" {
  description = "The admin password for Mosquitto."
  value       = local.admin_password
  sensitive   = true
}
