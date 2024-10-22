variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "percona-ps-operator"
}
variable "namespace" {
  description = "Namespace to install portainer chart into"
  type        = string
  default     = "percona"
}

variable "percona_ps_operator_chart_version" {
  description = "Version of portainer chart to install"
  type        = string
  default     = "0.7.0"
}

# Helm chart deployment can sometimes take longer than the default 5 minutes
variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes. Set a custom timeout here."
  default     = 800 # 10 minutes
}

variable "tags" {
  type = object({
    Name       = string
    Created_by = string
  })
}
