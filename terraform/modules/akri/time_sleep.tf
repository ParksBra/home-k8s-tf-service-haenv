# We want to wait for auto-discovery to have a chance to create the Akri instances
resource "time_sleep" "resources_creation" {
  count = var.enable_creation_wait ? 1 : 0

  depends_on = [
    helm_release.application
  ]

  triggers = {
    udev_instance_name = var.udev_instance_name
    udev_discovery_group_recursive = tostring(var.udev_discovery_group_recursive)
    udev_discovery_enabled = tostring(var.udev_discovery_enabled)
    udev_discovery_rules_list = join(",", var.udev_discovery_rules_list)
    udev_enabled = tostring(var.udev_enabled)
  }

  create_duration = local.creation_wait_check_duration
}
