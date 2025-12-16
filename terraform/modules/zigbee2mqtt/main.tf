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

  set = concat(
    [
      {
        name  = "image.repository"
        value = var.image_repository
      },
      {
        name  = "image.tag"
        value = var.image_tag
      },
      {
        name  = "image.pullPolicy"
        value = var.image_pull_policy
      },
      {
        name  = "service.type"
        value = var.service_type
      },
      {
        name  = "service.port"
        value = tostring(var.service_port)
      },
      {
        name  = "statefulSet.storage.enabled"
        value = tostring(var.data_persistence_enabled)
      },
      {
        name  = "statefulSet.storage.size"
        value = "${var.data_volume_size_gb}Gi"
      },
      {
        name  = "statefulSet.storage.storageClassName"
        value = var.data_storage_class_name
      },
      {
        name  = "statefulSet.resources.limits.cpu"
        value = "${var.pod_cpu_millicores}m"
      },
      {
        name  = "statefulSet.resources.limits.memory"
        value = "${var.pod_memory_mb}Mi"
      },
      {
        name  = "statefulSet.resources.requests.cpu"
        value = "${var.pod_cpu_millicores}m"
      },
      {
        name  = "statefulSet.resources.requests.memory"
        value = "${var.pod_memory_mb}Mi"
      },
      {
        name  = "zigbee2mqtt.mqtt.server"
        value = var.mqtt_broker_address
      },
      {
        name  = "zigbee2mqtt.mqtt.user"
        value = var.mqtt_broker_username
      },
      {
        name  = "zigbee2mqtt.serial.port"
        value = tostring(var.zigbee_serial_port)
      },
      {
        name  = "zigbee2mqtt.serial.disable_led"
        value = tostring(var.zigbee_disable_led)
      },
      {
        name  = "zigbee2mqtt.serial.adapter"
        value = var.zigbee_adapter_type
      },
      {
        name  = "zigbee2mqtt.serial.baudrate"
        value = tostring(var.zigbee_baudrate)
      },
      {
        name  = "zigbee2mqtt.serial.rtscts"
        value = tostring(var.zigbee_rtscts)
      },
      {
        name  = "ingress.enabled"
        value = tostring(var.ingress_enabled)
      },
      {
        name  = "ingress.ingressClassName"
        value = var.ingress_class_name
      },
      {
        name  = "ingress.hosts[0].host"
        value = var.ingress_host_address
      },
      {
        name  = "ingress.hosts[0].paths[0].path"
        value = "/"
      },
      {
        name  = "ingress.hosts[0].paths[0].pathType"
        value = "ImplementationSpecific"
      },
      {
        name  = "ingress.hosts[0].paths[1].path"
        value = "/api"
      },
      {
        name  = "ingress.hosts[0].paths[1].pathType"
        value = "ImplementationSpecific"
      },
      {
        name  = "ingress.tls[0].secretName"
        value = local.tls_secret_name
      },
      {
        name  = "ingress.tls[0].hosts[0]"
        value = var.ingress_host_address
      }
    ],
    flatten(
      [for k, v in var.pod_additional_resources :
        [
          {
            name  = "statefulSet.resources.requests.${replace(k, ".", "\\.")}"
            value = tostring(v)
          },
          {
            name  = "statefulSet.resources.limits.${replace(k, ".", "\\.")}"
            value = tostring(v)
          }
        ]
      ]
    ),
    [
      for k, v in var.ingress_annotations:
      {
        name  = "ingress.annotations.${replace(k, ".", "\\.")}"
        value = tostring(v)
      }
    ]
  )
  set_sensitive = [
    {
      name  = "zigbee2mqtt.mqtt.password"
      value = var.mqtt_broker_password
    }
  ]
}
