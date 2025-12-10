variable "namespace" {
  description = "The namespace in which to deploy the Home Assistant environment."
  type        = string
  default     = "homeassistant"
}

variable "create_namespace" {
  description = "Whether to create the Kubernetes namespace for the Home Assistant environment."
  type        = bool
  default     = true
}

variable "ingress_class_name" {
  description = "The ingress class name to use for the Home Assistant environment."
  type        = string
  default     = "nginx"
}

variable "ingress_annotations" {
  description = "A map of annotations to add to the Home Assistant ingress."
  type        = map(string)
  default     = {}
}

variable "mosquitto_admin_username" {
  description = "The admin username for the Mosquitto MQTT broker."
  type        = string
  default     = "admin"
}

variable "mosquitto_admin_password" {
  description = "The admin password for the Mosquitto MQTT broker. If not provided, a random password will be generated."
  type        = string
  default     = null
  sensitive   = true
}

variable "environment_domain" {
  description = "The primary external domain for the Home Assistant environment."
  type        = string
}

variable "homeassistant_subdomain" {
  description = "The subdomain for Home Assistant. If null, base environment_domain will be used."
  type        = string
  default     = null
}

variable "homeassistant_trusted_proxies" {
  description = "A list of trusted proxies for Home Assistant."
  type        = list
  default     = []
}

variable "homeassistant_codeserver_subdomain" {
  description = "The subdomain for the Home Assistant Code Server."
  type        = string
  default     = "code"
}

variable "zigbee2mqtt_subdomain" {
  description = "The subdomain for Zigbee2MQTT."
  type        = string
  default     = "z2m"
}

variable "enable_persistent_storage" {
  description = "Whether to enable persistent storage for the Home Assistant environment."
  type        = bool
  default     = true
}

variable "storage_class_name" {
  description = "The name of the storage class to use for persistent storage."
  type        = string
  default     = "standard"
}

variable "homeassistant_storage_size_gb" {
  description = "The size of the persistent volume for Home Assistant in GB."
  type        = number
  default     = 32
}

variable "mosquitto_storage_size_gb" {
  description = "The size of the persistent volume for Mosquitto in GB."
  type        = number
  default     = 8
}

variable "zigbee2mqtt_storage_size_gb" {
  description = "The size of the persistent volume for Zigbee2MQTT in GB."
  type        = number
  default     = 8
}

variable "akri_udev_subsystem" {
  description = "The udev subsystem to match for Akri device discovery."
  type        = string
  default     = "tty"
}

variable "akri_zigbee_radio_vendor_id" {
  description = "The USB vendor ID of the Zigbee radio for Akri device discovery. Default is 'ea60' for Home Assistant Connect ZBT-1."
  type        = string
  default     = "10c4"
}

variable "akri_zigbee_radio_product_id" {
  description = "The USB product ID of the Zigbee radio for Akri device discovery. Default is '10c4' for Home Assistant Connect ZBT-1."
  type        = string
  default     = "ea60"
}

# Chart shared variables
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

variable "mosquitto_enabled" {
  description = "Whether to deploy the Mosquitto MQTT broker."
  type        = bool
  default     = true
}

variable "zigbee2mqtt_enabled" {
  description = "Whether to deploy Zigbee2MQTT. Requires Mosquitto to be enabled."
  type        = bool
  default     = true
}

variable "codeserver_enabled" {
  description = "Whether to enable the Home Assistant Code Server."
  type        = bool
  default     = true
}
