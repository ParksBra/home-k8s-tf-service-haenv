locals {
  # Network reference
  parent_domain = data.terraform_remote_state.platform_network.outputs.external_parent_domain
  pod_network_cidr = data.terraform_remote_state.platform_network.outputs.pod_network_cidr
  pod_service_cidr = data.terraform_remote_state.platform_network.outputs.pod_service_cidr
  cluster_issuer_enabled = data.terraform_remote_state.platform_network.outputs.cert_manager_cluster_issuer_enabled
  cluster_issuer_name = data.terraform_remote_state.platform_network.outputs.cert_manager_cluster_issuer_name

  cloudflare_provider_api_token_secret_name = data.terraform_remote_state.platform_network.outputs.cloudflare_provider_api_token_secret_name
  dns_records_proxy_enabled = data.terraform_remote_state.platform_network.outputs.dns_records_proxy_enabled
  dns_records_default_comment = data.terraform_remote_state.platform_network.outputs.dns_records_default_comment
  dns_ttl_seconds = data.terraform_remote_state.platform_network.outputs.dns_ttl_seconds

  ingress_class_name = data.terraform_remote_state.platform_network.outputs.primary_ingress_class_name

  storage_class_name = data.terraform_remote_state.platform_storage.outputs.primary_storage_class_name

  create_dns_records = true
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

  haenv_ingress_annotations = local.cluster_issuer_enabled ? {
    "cert-manager.io/cluster-issuer" = local.cluster_issuer_name
  } : {}

  haenv_homeassistant_trusted_proxies = [
    "127.0.0.0/8",
    local.pod_network_cidr,
    local.pod_service_cidr
  ]

  haenv_mosquitto_admin_username = "admin"
  haenv_mosquitto_admin_password_infisical_secret_name = "mosquitto-account-password"
}
