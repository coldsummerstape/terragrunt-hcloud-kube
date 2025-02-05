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
  gitlab_token = local.environment_vars.locals.gitlab_token
  gitlab_org = local.environment_vars.locals.gitlab_org
  gitlab_repository = local.environment_vars.locals.gitlab_repository
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables that we need to pass for using the module. Here, parameters that are common for all
# environments are defined.
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  gitlab_token = local.gitlab_token
  gitlab_org = local.gitlab_org
  gitlab_repository = local.gitlab_repository
}