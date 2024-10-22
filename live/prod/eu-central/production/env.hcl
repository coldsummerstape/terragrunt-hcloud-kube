# Set common variables for the environment. They are automatically pulled into the root configuration terragrunt.hcl to
# pass them to child modules.
locals {
  environment = get_env("CI_ENVIRONMENT_NAME", "value")
  hcloud_token = get_env("HCLOUD_TOKEN", "value")
  hetzner_api_dns_key = get_env("HCLOUD_API_DNS_KEY", "value")
  prometheus_storage_size = get_env("PROMETHEUS_STORAGE_SIZE", "value")
  grafana_admin_password = get_env("GRAFANA_ADMIN_PASSWORD", "value")
  rabbitmq_admin_password = get_env("RABBITMQ_ADMIN_PASSWORD", "value")
  rabbitmq_storage_size = get_env("RABBITMQ_STORAGE_SIZE", "value")
}