module "homeassistant_environment" {
  count = local.haenv_enabled ? 1 : 0
  depends_on = [
    data.kubernetes_config_map.network_context,
    data.kubernetes_config_map.storage_context
  ]
  source = "../modules/_haenv"

  chart_linting_enabled = local.haenv_chart_linting_enabled

  namespace = local.haenv_namespace
  create_namespace = true

  ingress_class_name = local.haenv_ingress_class_name
  ingress_annotations = local.haenv_ingress_annotations

  mosquitto_admin_username = local.haenv_mosquitto_admin_username

  homeassistant_trusted_proxies = local.haenv_homeassistant_trusted_proxies

  external_domain = local.external_domain

  storage_class_name = local.storage_class_name

  homeassistant_storage_size_gb = local.haenv_homeassistant_storage_size_gb
  mosquitto_storage_size_gb = local.haenv_mosquitto_storage_size_gb
  zigbee2mqtt_storage_size_gb = local.haenv_zigbee2mqtt_storage_size_gb
}
