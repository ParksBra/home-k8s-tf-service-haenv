resource "helm_release" "application" {
  depends_on = [
    data.kubernetes_namespace.namespace
  ]

  name       = local.chart_install_name
  repository = local.repository
  chart      = local.chart_reference
  version    = var.chart_version

  namespace        = data.kubernetes_namespace.namespace.metadata[0].name
  create_namespace = false

  dependency_update = var.chart_dependency_update
  lint              = var.chart_linting_enabled
  recreate_pods     = var.chart_recreate_pods
  upgrade_install   = var.chart_upgrade_install
  replace           = var.chart_replace
  cleanup_on_fail   = var.chart_cleanup_on_fail

  values = [
    yamlencode(
      {
        udev = {
          configuration = {
            discoveryDetails = {
              udevRules = var.udev_discovery_rules_list
            }
          }
        }
        agent = {
          tolerations = var.agent_tolerations
        }
        controller = {
          tolerations = var.controller_tolerations
        }
      }
    )
  ]

  set = concat(
    [
      {
        name  = "kubernetesDistro"
        value = var.kubernetes_distro
      },
      {
        name  = "controller.enabled"
        value = tostring(var.controller_enabled)
      },
      {
        name  = "controller.image.repository"
        value = var.controller_image_repository
      },
      {
        name  = "controller.image.tag"
        value = var.controller_image_tag
      },
      {
        name  = "controller.image.pullPolicy"
        value = var.controller_image_pull_policy
      },
      {
        name  = "controller.onlyOnControlPlane"
        value = tostring(var.controller_only_on_control_plane)
      },
      {
        name  = "controller.allowOnControlPlane"
        value = tostring(var.controller_allow_on_control_plane)
      },
      {
        name = "agent.enabled"
        value = tostring(var.agent_enabled)
      },
      {
        name  = "agent.image.repository"
        value = var.agent_image_repository
      },
      {
        name  = "agent.image.fullRepository"
        value = var.agent_image_full_repository
      },
      {
        name  = "agent.image.tag"
        value = var.agent_image_tag
      },
      {
        name  = "agent.image.pullPolicy"
        value = var.agent_image_pull_policy
      },
      {
        name  = "udev.configuration.enabled"
        value = tostring(var.udev_enabled)
      },
      {
        name  = "udev.configuration.name"
        value = var.udev_instance_name
      },
      {
        name  = "udev.configuration.discoveryDetails.groupRecursive"
        value = tostring(var.udev_discovery_group_recursive)
      },
      {
        name  = "udev.discovery.enabled"
        value = tostring(var.udev_discovery_enabled)
      }
    ],
    [
        for k, v in var.agent_node_selector : {
          name  = "agent.nodeSelectors.${replace(k, ".", "\\.")}"
          value = tostring(v)
        }
    ],
    [
        for k, v in var.controller_node_selector : {
          name  = "controller.nodeSelectors.${replace(k, ".", "\\.")}"
          value = tostring(v)
        }
    ],
  )
}
