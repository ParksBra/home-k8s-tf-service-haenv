resource "helm_release" "application" {
  depends_on = [
    data.kubernetes_namespace.namespace,
    data.jinja_template.configuration,
    data.external.mosquitto_password_hasher
  ]

  name       = local.chart_install_name
  repository = local.repository
  chart      = local.chart_reference
  version    = var.chart_version

  namespace        = data.kubernetes_namespace.namespace.metadata[0].name
  create_namespace = false

  dependency_update = var.chart_dependency_update
  lint              = var.chart_linting_enabled
  recreate_pods     = var.chart_recreate_pods
  upgrade_install   = var.chart_upgrade_install
  replace           = var.chart_replace
  cleanup_on_fail   = var.chart_cleanup_on_fail

  set = [
    {
      name  = "replicaCount"
      value = tostring(var.pod_replicas)
    },
    {
      name  = "strategyType"
      value = var.pod_update_strategy
    },
    {
      name  = "image.repository"
      value = var.image_repository
    },
    {
      name  = "image.tag"
      value = var.image_tag
    },
    {
      name  = "image.pullPolicy"
      value = var.image_pull_policy
    },
    {
      name  = "config"
      value = replace(data.jinja_template.configuration.result, ",", "\\,")
    },
    {
      name  = "persistence.enabled"
      value = tostring(var.data_persistence_enabled)
    },
    {
      name  = "persistence.storageClass"
      value = var.data_storage_class_name
    },
    {
      name  = "persistence.size"
      value = "${var.data_volume_size_gb}Gi"
    },
    {
      name  = "persistence.accessMode"
      value = var.data_volume_access_mode
    },
    {
      name  = "persistence.mountPath"
      value = local.persistence_path
    },
    {
      name  = "service.type"
      value = var.service_type
    },
    {
      name  = "service.externalTrafficPolicy"
      value = var.service_external_traffic_policy
    },
    {
      name  = "ports.mqtt.port"
      value = tostring(var.mqtt_port)
    },
    {
      name  = "ports.mqtt.protocol"
      value = "TCP"
    },
    {
      name  = "ports.websocket.port"
      value = tostring(var.websocket_port)
    },
    {
      name  = "ports.websocket.protocol"
      value = "TCP"
    },
    {
      name  = "resources.requests.cpu"
      value = "${var.pod_cpu_millicores}m"
    },
    {
      name  = "resources.requests.memory"
      value = "${var.pod_memory_mb}Mi"
    },
    {
      name  = "resources.limits.cpu"
      value = "${var.pod_cpu_millicores}m"
    },
    {
      name  = "resources.limits.memory"
      value = "${var.pod_memory_mb}Mi"
    }
  ]
  set_sensitive = [
    {
      name  = "authentication.passwordEntries"
      value = "${var.admin_username}:${data.external.mosquitto_password_hasher.result.hashed_password}"
    }
  ]
}
