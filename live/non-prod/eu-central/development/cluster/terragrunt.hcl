# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the Terragrunt configuration, a thin wrapper for Terraform and OpenTofu that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common to all
# components and environments, such as remote state setup.
include "root" {
  path = find_in_parent_folders()
}

# Include the common environment configuration for the component. The common environment configuration contains settings
# that are common for the component across all environments.
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/cluster.hcl"
  # We want to reference variables from the included configuration in this configuration, so we expose them.
  expose = true
}

terraform {
  source = "https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner.git"
}

# ---------------------------------------------------------------------------------------------------------------------
# ПАРАМЕТРЫ МОДУЛЯ СПЕЦИФИЧНЫЕ ДЛЯ ОКРУЖЕНИЯ
# ---------------------------------------------------------------------------------------------------------------------
inputs = {}