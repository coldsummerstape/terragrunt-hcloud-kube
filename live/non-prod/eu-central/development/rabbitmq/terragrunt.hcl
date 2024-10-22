# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the Terragrunt configuration, a thin wrapper for Terraform and OpenTofu that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common to all
# components and environments, such as remote state configuration.
include "root" {
  path = find_in_parent_folders()
}

# Include the environment common configuration for the component. The environment common configuration contains settings
# that are common for the component across all environments.
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/rabbitmq.hcl"
  # We want to reference variables from the included configuration in this configuration, so we expose them.
  expose = true
}

terraform {
  source = "${dirname(find_in_parent_folders())}/modules/rabbitmq"
}

# ---------------------------------------------------------------------------------------------------------------------
# ENVIRONMENT-SPECIFIC MODULE PARAMETERS
# ---------------------------------------------------------------------------------------------------------------------

dependency "cluster" {
  config_path = "../cluster"
}

generate "kubeconfig" {
  path      = "kubeconfig.yaml"
  if_exists = "overwrite_terragrunt"
  contents  = dependency.cluster.outputs.kubeconfig
}

generate "helm_provider" {
  path      = "helm_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.43.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.31.0"
    }
  }
}

# Helm Provider
provider "helm" {
  kubernetes {
    config_path = "./kubeconfig.yaml"
  }
}

# Kubernetes Provider
provider "kubernetes" {
    config_path = "./kubeconfig.yaml"
}
EOF
}

inputs = {
  providers = {
    helm = "helm"
  }

  count  = 1
  tags = {
    Name       = "rabbitmq"
    Created_by = "terraform"
  }

  values_file = "values-rabbitmq.yaml"
  
  depends_on = ["../cluster"]
}