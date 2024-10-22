
variable "hetzner_api_dns_key" {
  description = "API key for Hetzner DNS"
  type        = string
}

variable "release_name" {
  type        = string
  description = "Helm release name"
  default     = "external-secrets"
}

variable "namespace" {
  description = "Namespace to install the chart into"
  type        = string
  default     = "external-secrets"
}

variable "external_secrets_chart_version" {
  description = "Version of external-secrets chart to install"
  type        = string
  default     = "0.10.0"
}

# Увеличенный таймаут для развертывания Helm чарта
variable "timeout_seconds" {
  type        = number
  description = "Helm chart deployment can sometimes take longer than the default 5 minutes. Set a custom timeout here."
  default     = 800 # 10 minutes
}

variable "values_file" {
  description = "The name of the helm chart values file to use"
  type        = string
  default     = "values.yaml"
}

variable "tags" {
  type = object({
    Name       = string
    Created_by = string
  })
}
