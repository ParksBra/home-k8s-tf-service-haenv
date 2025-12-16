output "namespace" {
  description = "The name of the namespace in which Akri is deployed."
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

output "chart_reference" {
  description = "The Helm chart reference for Akri."
  value       = local.chart_reference
}

output "controller_enabled" {
  description = "Whether the Akri controller is enabled."
  value       = var.controller_enabled
}

output "agent_enabled" {
  description = "Whether the Akri agent is enabled."
  value       = var.agent_enabled
}

output "udev_enabled" {
  description = "Whether UDEV configuration is enabled in Akri."
  value       = var.udev_enabled
}

output "udev_instance_name" {
  description = "The name of the UDEV instance configured in Akri."
  value       = var.udev_instance_name
}

output "udev_resource_name" {
  description = "The name of the UDEV resource configured in Akri."
  value       = "akri.sh/${var.udev_instance_name}"
}
