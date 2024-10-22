# ---------------------------------------------------------------------------------------------------------------------
# GENERAL TERRAGRUNT CONFIGURATION
# This is the general component configuration for the web server cluster. Here, common variables for each environment
# are defined to deploy the web server cluster. This configuration will be merged with the environment configuration
# through the include block.
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract common variables for reuse
  env = local.environment_vars.locals.environment
  prometheus_storage_size = local.environment_vars.locals.prometheus_storage_size
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables that we need to pass for using the module. Here, parameters that are common for all
# environments are defined.
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  prometheus_storageclass_name = "hcloud-volumes"
  prometheus_storage_size      = local.prometheus_storage_size
}