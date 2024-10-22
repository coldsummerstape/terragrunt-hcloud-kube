# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform/OpenTofu that provides additional tools for working with multiple modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract necessary variables for convenient access
  account_name = local.account_vars.locals.account_name
  aws_region   = local.region_vars.locals.aws_region
  hcloud_token = local.environment_vars.locals.hcloud_token
}

# Generate Terraform provider block
# Generate Terraform provider block for AWS and Hetzner Cloud

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF

provider "aws" {
  region = "${local.aws_region}"
}

provider "hcloud" {
  token = "${local.hcloud_token}"
}
EOF
}

# Configure Terragrunt to automatically save tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "bucket-name"
    key            = "tf.tfstate"
    region         = local.aws_region
    dynamodb_table = "terraform-state-lock"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Configure repositories to search when running 'terragrunt catalog'
catalog {
  urls = [
    "https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example",
    "https://github.com/gruntwork-io/terraform-aws-utilities",
    "https://github.com/gruntwork-io/terraform-kubernetes-namespace"
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. They are automatically merged into the child
# `terragrunt.hcl` config through the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root-level variables that can be inherited by all resources. This is especially useful in multi-account configurations
# where terraform_remote_state data sources are placed directly in the modules.
inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)