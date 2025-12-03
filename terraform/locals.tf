locals {
  # Kubernetes Dashboard configuration
  kubernetes_dashboard_enabled = true
  kubernetes_dashboard_create = local.kubernetes_dashboard_enabled && !local.disable_nonplatform_modules
  kubernetes_dashboard_namespace = "kubernetes-dashboard"
  kubernetes_dashboard_ingress_class_name = "nginx"
  kubernetes_dashboard_ingress_host_address = "dashboard.k8s.${local.parent_domain}"
  kubernetes_dashboard_chart_linting_enabled = true
  kubernetes_dashboard_ingress_annotations = {
    "cert-manager.io/cluster-issuer" = module.network.cert_manager_cluster_issuer_name
  }
}

locals {
  # Homeassistant environment configuration
  haenv_enabled = true
  haenv_namespace = "home-assistant"
  haenv_ingress_class_name = "nginx"
  haenv_homeassistant_storage_size_gb = 32
  haenv_mosquitto_storage_size_gb = 8
  haenv_zigbee2mqtt_storage_size_gb = 8

  haenv_chart_linting_enabled = false

  haenv_ingress_annotations = {
    "cert-manager.io/cluster-issuer" = module.network.cert_manager_cluster_issuer_name
  }

  haenv_homeassistant_trusted_proxies = [
    "127.0.0.0/8",
    local.pod_network_cidr,
    local.pod_service_cidr
  ]

  haenv_mosquitto_admin_username = "admin"
  haenv_mosquitto_admin_password_infisical_secret_name = "mosquitto-account-password"
}
