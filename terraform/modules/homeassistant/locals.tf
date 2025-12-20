locals {
  repository = "http://pajikos.github.io/home-assistant-helm-chart"
  chart_reference = "home-assistant"

  chart_install_name = var.chart_install_name != null ? var.chart_install_name : local.chart_reference

  namespace = var.namespace != null ? var.namespace : local.chart_install_name

  service_account_name       = "${local.chart_install_name}-sa"
  tls_secret_name            = "${local.chart_install_name}-ingress-tls"
  codeserver_tls_secret_name = "${local.chart_install_name}-codeserver-ingress-tls"
  codeserver_password_secret_name = "${local.chart_install_name}-codeserver-auth"

  codeserver_generate_password = var.codeserver_password == null && var.codeserver_auth_enabled ? true : false
  codeserver_generated_password_length = 32

  codeserver_password = var.codeserver_password != null ? var.codeserver_password : random_password.codeserver_password[0].result
}

locals {
  # Jinja Template Data Sources
  configuration_template_path = "${path.module}/templates/configuration.yaml.j2"
  init_script_template_path   = "${path.module}/templates/init_script.sh.j2"
  jinja_context = jsonencode({
    logging_level             = var.logging_level
    max_configuration_backups = var.max_configuration_backups
    included_configurations   = var.included_configurations
    trusted_proxies           = var.trusted_proxies
    ip_ban_enabled            = var.ip_ban_enabled
    ip_ban_threshold          = var.ip_ban_threshold
    use_x_forwarded_for       = var.use_x_forwarded_for
    enable_my_ha              = var.enable_my_ha
    enable_mobile_app         = var.enable_mobile_app
    force_configuration_init  = var.force_configuration_init
  })
}
