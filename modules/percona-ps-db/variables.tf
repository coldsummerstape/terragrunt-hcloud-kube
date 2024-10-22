variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "percona-ps-db"
}
variable "namespace" {
  description = "Namespace to install percona-pxc-db chart into"
  type        = string
  default     = "percona"
}

variable "percona_ps_db_chart_version" {
  description = "Version of percona-ps-db chart to install"
  type        = string
  default     = "0.7.0"
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
  default     = "percona-ps-db-default-values.yaml"
}

variable "tags" {
  type = object({
    Name       = string
    Created_by = string
  })
}
