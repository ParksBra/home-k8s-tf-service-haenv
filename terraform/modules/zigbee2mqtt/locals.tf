locals {
  repository = "https://charts.zigbee2mqtt.io"
  chart_reference = "zigbee2mqtt"

  chart_install_name = var.chart_install_name != null ? var.chart_install_name : local.chart_reference

  namespace = var.namespace != null ? var.namespace : local.chart_install_name

  tls_secret_name = "${local.chart_install_name}-ingress-tls"
}
