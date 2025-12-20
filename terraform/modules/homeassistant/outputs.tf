output "namespace" {
  description = "The name of the namespace in which Home Assistant is deployed."
  value       = data.kubernetes_namespace.namespace.metadata[0].name
}

output "chart_id" {
  description = "The Helm release ID for Home Assistant."
  value       = helm_release.application.id
}

output "chart_name" {
  description = "The Helm chart reference for Home Assistant."
  value       = helm_release.application.name
}

output "service_address" {
  description = "The address of the Home Assistant service."
  value       = "${helm_release.application.name}.${data.kubernetes_namespace.namespace.metadata[0].name}.svc"
}

output "service_port" {
  description = "The port of the Home Assistant service."
  value       = var.service_port
}

output "ingress_enabled" {
  description = "Whether ingress is enabled for the Home Assistant service."
  value       = var.ingress_enabled
}

output "ingress_address" {
  description = "The ingress address of the Home Assistant service."
  value       = var.ingress_enabled ? var.ingress_host_address : ""
}

output "codeserver_enabled" {
  description = "Whether the Home Assistant code server is enabled."
  value       = var.codeserver_enabled
}

output "codeserver_password_generated" {
  description = "Whether the Home Assistant code server password was generated."
  value       = var.codeserver_enabled ? local.codeserver_generate_password : false
}

output "codeserver_password" {
  description = "The password for the Home Assistant code server."
  value       = var.codeserver_enabled ? local.codeserver_password : ""
  sensitive   = true
}

output "codeserver_service_address" {
  description = "The address of the Home Assistant code server service."
  value       = var.codeserver_enabled ? "${helm_release.application.name}-codeserver.${data.kubernetes_namespace.namespace.metadata[0].name}.svc" : ""
}

output "codeserver_service_port" {
  description = "The port of the Home Assistant code server service."
  value       = var.codeserver_enabled ? var.codeserver_service_port : null
}

output "codeserver_ingress_enabled" {
  description = "Whether ingress is enabled for the Home Assistant code server."
  value       = var.codeserver_enabled ? var.codeserver_ingress_enabled : false
}

output "codeserver_ingress_address" {
  description = "The ingress address of the Home Assistant code server."
  value       = var.codeserver_enabled && var.codeserver_ingress_enabled ? var.codeserver_ingress_host_address : ""
}
