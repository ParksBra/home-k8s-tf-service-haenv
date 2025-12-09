locals {
  # Network reference
  external_domain = data.kubernetes_config_map.network_context.data.external_domain
  external_ingress_ip = data.kubernetes_config_map.network_context.data.external_ingress_ip

  pod_network_cidr = data.kubernetes_config_map.network_context.data.pod_network_cidr
  service_network_cidr = data.kubernetes_config_map.network_context.data.service_network_cidr
  cluster_domain = data.kubernetes_config_map.network_context.data.cluster_domain

  cluster_issuer_created = tobool(data.kubernetes_config_map.network_context.data.cert_manager_cluster_issuer_created)
  cluster_issuer_name = data.kubernetes_config_map.network_context.data.cert_manager_cluster_issuer_name

  dns_records_default_comment = data.kubernetes_config_map.network_context.data.dns_records_default_comment
  dns_records_proxy_enabled = tobool(data.kubernetes_config_map.network_context.data.dns_records_proxy_enabled)
  dns_ttl_seconds = tonumber(data.kubernetes_config_map.network_context.data.dns_ttl_seconds)

  ingress_class_name = data.kubernetes_config_map.network_context.data.primary_ingress_class_name

  storage_class_name = data.kubernetes_config_map.storage_context.data.primary_storage_class_name
}

locals {
  # Homeassistant environment configuration
  haenv_enabled = true
  haenv_namespace = "home-assistant"
  haenv_ingress_class_name = local.ingress_class_name
  haenv_homeassistant_storage_size_gb = 32
  haenv_mosquitto_storage_size_gb = 8
  haenv_zigbee2mqtt_storage_size_gb = 8

  haenv_chart_linting_enabled = false

  haenv_ingress_annotations = local.cluster_issuer_created ? {
    "cert-manager.io/cluster-issuer" = local.cluster_issuer_name
  } : {}

  create_dns_records = true

  haenv_homeassistant_trusted_proxies = [
    "127.0.0.0/8",
    local.pod_network_cidr,
    local.service_network_cidr
  ]

  haenv_mosquitto_admin_username = "admin"
}
