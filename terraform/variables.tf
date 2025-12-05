variable "python_executable" {
  description = "The path to the Python executable for Mosquitto password hashing script"
  type        = string
}

variable "azuredevops_library_project_id" {
  description = "The Azure DevOps project ID containing the variable library"
  type        = string
}

variable "azuredevops_library_name" {
  description = "The name of the Azure DevOps variable library"
  type        = string
}
