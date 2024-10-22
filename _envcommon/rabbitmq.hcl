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
  rabbitmq_admin_password = local.environment_vars.locals.rabbitmq_admin_password
  rabbitmq_storage_size = local.environment_vars.locals.rabbitmq_storage_size
  rabbitmq_url = local.environment_vars.locals.rabbitmq_url
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables that we need to pass for using the module. Here, parameters that are common for all
# environments are defined.
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  rabbitmq_storageclass_name = "hcloud-volumes"
  rabbitmq_admin_password    = local.rabbitmq_admin_password
  rabbitmq_storage_size      = local.rabbitmq_storage_size
  rabbitmq_url               = local.rabbitmq_url
}