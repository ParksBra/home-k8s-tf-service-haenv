module "homeassistant_environment" {
  count = local.haenv_enabled ? 1 : 0
  depends_on = [
    module.network,
    module.storage,
  ]
  source = "../modules/_haenv"

  chart_linting_enabled = local.haenv_chart_linting_enabled

  python_executable = var.python_executable

  namespace = local.haenv_namespace
  create_namespace = true

  ingress_class_name = local.haenv_ingress_class_name
  ingress_annotations = local.haenv_ingress_annotations

  mosquitto_admin_username = local.haenv_mosquitto_admin_username
  mosquitto_admin_password = data.infisical_secrets.environment.secrets[local.haenv_mosquitto_admin_password_infisical_secret_name].value

  homeassistant_trusted_proxies = local.haenv_homeassistant_trusted_proxies

  parent_domain = local.parent_domain

  storage_class_name = kubernetes_storage_class.service.metadata[0].name

  homeassistant_storage_size_gb = local.haenv_homeassistant_storage_size_gb
  mosquitto_storage_size_gb = local.haenv_mosquitto_storage_size_gb
  zigbee2mqtt_storage_size_gb = local.haenv_zigbee2mqtt_storage_size_gb
}
