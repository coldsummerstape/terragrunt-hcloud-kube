# Set common variables for the region. They are automatically pulled into the root configuration terragrunt.hcl to
# configure the remote state bucket and pass them to child modules as input data.
locals {
  hetzner_region = "eu-central"
  aws_region = "eu-central-1"
}