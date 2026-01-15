locals {
  repository = "https://project-akri.github.io/akri"
  chart_reference = "akri"

  chart_install_name = var.chart_install_name != null ? var.chart_install_name : local.chart_reference

  namespace = var.namespace != null ? var.namespace : local.chart_install_name

  creation_wait_check_duration = "${var.creation_wait_seconds}s"
}
