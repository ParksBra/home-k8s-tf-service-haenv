module "akri" {
  count = var.zigbee2mqtt_enabled ? 1 : 0
  source = "../akri"
  depends_on = [
    data.kubernetes_namespace.namespace,
  ]

  namespace                      = data.kubernetes_namespace.namespace.metadata[0].name

  create_namespace               = false

  udev_discovery_enabled         = true
  udev_instance_name             = "${data.kubernetes_namespace.namespace.metadata[0].name}-udev"
  udev_discovery_group_recursive = true
  udev_discovery_rules_list      = local.akri_udev_discovery_rules_list

  chart_linting_enabled = false

  chart_version = "0.13.20"

  agent_tolerations = [
    {
      key      = "node-role.kubernetes.io/control-plane"
      operator = "Exists"
      effect   = "NoSchedule"
    }
  ]
  controller_node_selector = {
    "node-role.kubernetes.io/control-plane" = ""
  }
  controller_tolerations = [
    # {
    #   key      = "node-role.kubernetes.io/control-plane"
    #   operator = "Exists"
    #   effect   = "NoSchedule"
    # }
  ]
}

data "kubernetes_resources" "akri_udev_instances" {
  count = var.zigbee2mqtt_enabled ? 1 : 0
  depends_on = [
    module.akri
  ]
  api_version    = "akri.sh/v0"
  kind           = "Instance"
  namespace      = module.akri[0].namespace
  limit          = 1 # Hopefully in any future there will only be one instance and udev configuration. TODO: improve this if needed.
}
