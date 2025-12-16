# Chart vars
variable "namespace" {
  description = "The namespace in which to deploy the Helm chart."
  type        = string
  default     = null
}

variable "create_namespace" {
  description = "Whether to create the namespace for the module."
  type        = bool
  default     = true
}

variable "chart_install_name" {
  description = "The name used to install the Helm chart."
  type        = string
  default     = null
}

variable "chart_version" {
  description = "The version of the Helm chart to deploy. If null, the latest version is used."
  type        = string
  default     = null
}

variable "chart_linting_enabled" {
  description = "Whether to enable Helm chart linting."
  type        = bool
  default     = true
}

variable "chart_recreate_pods" {
  description = "Whether to recreate pods when deploying the Helm chart."
  type        = bool
  default     = false
}

variable "chart_upgrade_install" {
  description = "Whether to install the Helm chart if it is not already installed during an upgrade."
  type        = bool
  default     = true
}

variable "chart_replace" {
  description = "Whether to replace the Helm chart if it is already installed."
  type        = bool
  default     = false
}

variable "chart_dependency_update" {
  description = "Whether to update chart dependencies before installing or upgrading the Helm chart."
  type        = bool
  default     = true
}

variable "chart_cleanup_on_fail" {
  description = "Whether to cleanup resources if the Helm chart installation or upgrade fails."
  type        = bool
  default     = true
}

# Home Assistant vars
variable "image_repository" {
  description = "The Docker image repository for Home Assistant."
  type        = string
  default     = "ghcr.io/home-assistant/home-assistant"
}

variable "image_tag" {
  description = "The Docker image tag for Home Assistant."
  type        = string
  default     = "latest"
}

variable "image_pull_policy" {
  description = "The image pull policy for the Home Assistant Docker image."
  type        = string
  default     = "Always"
}

variable "data_storage_persistence_enabled" {
  description = "Whether to enable persistent storage for Home Assistant."
  type        = bool
  default     = true
}

variable "data_storage_class_name" {
  description = "The storage class name for Home Assistant persistent storage."
  type        = string
  default     = "standard"
}

variable "data_volume_size_gb" {
  description = "The size of the persistent volume for Home Assistant data in GB."
  type        = number
  default     = 8
}

variable "data_storage_access_mode" {
  description = "The access mode for the Home Assistant persistent volume."
  type        = string
  default     = "ReadWriteOnce"
}

variable "service_type" {
  description = "The type of Kubernetes service to create for Home Assistant."
  type        = string
  default     = "ClusterIP"
}

variable "service_port" {
  description = "The port exposed by the Home Assistant service."
  type        = number
  default     = 8123
}

variable "ingress_enabled" {
  description = "Whether to enable ingress for Home Assistant."
  type        = bool
  default     = false
}

variable "ingress_host_address" {
  description = "The host address for the Home Assistant ingress."
  type        = string
  default     = "homeassistant.local"
}

variable "ingress_class_name" {
  description = "The ingress class name to use for the Home Assistant ingress."
  type        = string
  default     = "nginx"
}

variable "ingress_annotations" {
  description = "A map of annotations to add to the Home Assistant ingress."
  type        = map
  default     = {}
}

variable "pod_host_network_enabled" {
  description = "Whether to enable host networking for the Home Assistant pod."
  type        = bool
  default     = false
}

variable "pod_dns_policy" {
  description = "The DNS policy for the Home Assistant pod."
  type        = string
  default     = "ClusterFirst"
}

variable "pod_update_strategy" {
  description = "The pod update strategy for Home Assistant."
  type        = string
  default     = "RollingUpdate"
}

variable "pod_memory_mb" {
  description = "The memory request for the Home Assistant pod in MB."
  type        = number
  default     = 1024
}

variable "pod_cpu_millicores" {
  description = "The CPU request for the Home Assistant pod in millicores."
  type        = number
  default     = 1000
}

# Home Assistant configuration vars
variable "logging_level" {
  description = "The logging level for Home Assistant."
  type        = string
  default     = "info"
}

variable "ip_ban_enabled" {
  description = "Whether to enable IP banning in Home Assistant."
  type        = bool
  default     = true
}

variable "ip_ban_threshold" {
  description = "The number of failed login attempts before an IP is banned."
  type        = number
  default     = 8
}

variable "use_x_forwarded_for" {
  description = "Whether to use the X-Forwarded-For header for client IP addresses."
  type        = bool
  default     = true
}

variable "trusted_proxies" {
  description = "A list of trusted proxy IP addresses for Home Assistant."
  type        = list
  default     = [
    "127.0.0.0/8"
  ]
}

variable "enable_my_ha" {
  description = "Whether to enable the My Home Assistant integration."
  type        = bool
  default     = false
}

variable "enable_mobile_app" {
  description = "Whether to enable the Mobile App integration."
  type        = bool
  default     = false
}

variable "included_configurations" {
  description = "A list of additional configurations (singular reference names, e.g., automation, script) to include in Home Assistant."
  type        = list
  default     = [
    "automation",
    "script",
    "scene",
    "group"
  ]
}

variable "force_configuration_init" {
  description = "Whether to force re-initialization of the Home Assistant configuration on startup. This will overwrite the existing configuration, updating it with the current settings."
  type        = bool
  default     = false
}

variable "max_configuration_backups" {
  description = "The maximum number of configuration backup files to keep."
  type        = number
  default     = 10
}

# Home Assistant Code Server add-on vars
variable "codeserver_enabled" {
  description = "Whether to enable the Home Assistant Code Server add-on."
  type        = bool
  default     = false
}

variable "codeserver_image_repository" {
  description = "The Docker image repository for the Home Assistant Code Server add-on."
  type        = string
  default     = "ghcr.io/coder/code-server"
}

variable "codeserver_image_tag" {
  description = "The Docker image tag for the Home Assistant Code Server add-on."
  type        = string
  default     = "latest"
}

variable "codeserver_image_pull_policy" {
  description = "The image pull policy for the Home Assistant Code Server Docker image."
  type        = string
  default     = "Always"
}

variable "codeserver_service_type" {
  description = "The type of Kubernetes service to create for the Home Assistant Code Server."
  type        = string
  default     = "ClusterIP"
}

variable "codeserver_service_port" {
  description = "The port exposed by the Home Assistant Code Server service."
  type        = number
  default     = 12321
}

variable "codeserver_ingress_enabled" {
  description = "Whether to enable ingress for the Home Assistant Code Server."
  type        = bool
  default     = false
}

variable "codeserver_ingress_host_address" {
  description = "The host address for the Home Assistant Code Server ingress."
  type        = string
  default     = "code.homeassistant.local"
}

variable "codeserver_ingress_class_name" {
  description = "The ingress class name to use for the Home Assistant Code Server ingress."
  type        = string
  default     = "nginx"
}

variable "codeserver_ingress_annotations" {
  description = "A map of annotations to add to the Home Assistant Code Server ingress."
  type        = map
  default     = {}
}

variable "codeserver_auth_enabled" {
  description = "Whether to enable authentication for the Home Assistant Code Server."
  type        = bool
  default     = true
}

variable "codeserver_password" {
  description = "The password for the Home Assistant Code Server. If null, a random password will be generated."
  type        = string
  default     = null
  sensitive   = true
}
