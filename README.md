
Where:

* **Account**: At the top level are all your Hetzner accounts, such as `stage-account`, `prod-account`, `mgmt-account`,
  etc. If everything is deployed in one AWS account, there will be only one folder at the root level (e.g.,
  `main-account`).

* **Region**: Each account will have one or more [Hetzner regions](https://docs.hetzner.com/cloud/general/locations/), such as
  `eu-central`, `us-east`, and `us-west`, where you have deployed resources. There may also be a `_global` folder,
  which defines resources available in all regions.

* **Environment**: Each region will have one or more "environments", such as `dev`, `stage`, etc. Typically,
  an environment corresponds to one project in the cloud that
  isolates this environment from everything else in that account. There may also be a `_global` folder,
  which defines resources available in all environments of that region.

* **Resource**: In each environment, you deploy all the resources for that environment, each module folder = a resource in the cluster.

## Creating and using root-level (account) variables

In situations where you have multiple accounts or regions, you often need to pass common variables to each
of your modules. Instead of copying/pasting the same variables into each `terragrunt.hcl` file, in each region, and in
each environment, you can inherit them from `inputs` defined in the root `terragrunt.hcl` file.

## Custom terraform modules for creating k8s objects.

A collection of custom terraform modules has been added to the project. The modules are located in the modules folder.
The current list of modules is: