variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "portainer"
}
variable "namespace" {
  description = "Namespace to install portainer chart into"
  type        = string
  default     = "portainer"
}

variable "portainer_chart_version" {
  description = "Version of portainer chart to install"
  type        = string
  default     = "1.0.51"
}

# Helm chart deployment can sometimes take longer than the default 5 minutes
variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes. Set a custom timeout here."
  default     = 800 # 10 minutes
}

variable "values_file" {
  description = "The name of the portainer helm chart values file to use"
  type        = string
  default     = "values.yaml"
}

variable "tags" {
  type = object({
    Name       = string
    Created_by = string
  })
}
