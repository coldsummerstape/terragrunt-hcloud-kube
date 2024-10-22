variable "hetzner_api_dns_key" {
  description = "API key for Hetzner DNS"
  type        = string
}

variable "values_file" {
  description = "The name of the cert-manager-webhook-hetzner Helm chart values file to use"
  type        = string
  default     = "cert-manager-webhook-hetzner-values.yaml"
}
