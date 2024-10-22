# Terragrunt Hetzner Cloud Kubernetes Deployment

## Overview

This project provides an automated approach to deploying a Kubernetes cluster on Hetzner Cloud using [Terragrunt](https://terragrunt.gruntwork.io/) and OpenTofu/Terraform. The project includes custom Terraform modules to manage various Kubernetes objects, as well as configuration and environment setup instructions for AWS authentication, Hetzner Cloud API integration, and more.

## Prerequisites

Ensure you have the following tools installed on your system:

- **Terraform** or **OpenTofu**
- **Packer** (used for snapshot creation)
- **kubectl** CLI (for managing your Kubernetes cluster)
- **hcloud** CLI (for interacting with Hetzner Cloud)

### Installation using Homebrew

You can install the necessary tools via Homebrew:

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform  # OR brew install opentofu
brew install packer
brew install kubectl
brew install hcloud

<!-- GETTING STARTED -->

## Getting Started

Follow those simple steps, and your world's cheapest Kubernetes cluster will be up and running.

### ✔️ Prerequisites

First and foremost, you need to have a Hetzner Cloud account. You can sign up for free [here](https://hetzner.com/cloud/).

Then you'll need to have [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) or [tofu](https://opentofu.org/docs/intro/install/), [packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli#installing-packer) (for the initial snapshot creation only, no longer needed once that's done), [kubectl](https://kubernetes.io/docs/tasks/tools/) cli and [hcloud](https://github.com/hetznercloud/cli) the Hetzner cli for convenience. The easiest way is to use the [homebrew](https://brew.sh/) package manager to install them (available on Linux, Mac, and Windows Linux Subsystem).

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform # OR brew install opentofu
brew install packer
brew install kubectl
brew install hcloud
```

### 💡 [Do not skip] OpenSUSE MicroOS snapshot

1. Create a project in your [Hetzner Cloud Console](https://console.hetzner.cloud/), and go to **Security > API Tokens** of that project to grab the API key, it needs to be Read & Write. Take note of the key! ✅
2. Generate a passphrase-less ed25519 SSH key pair for your cluster; take note of the respective paths of your private and public keys. Or, see our detailed [SSH options](https://github.com/kube-hetzner/terraform-hcloud-kube-hetzner/blob/master/docs/ssh.md). ✅
3. Now navigate to where you want to have your project live and execute the following command, which will help you get started with a **new folder** along with the required files, and will propose you to create a needed MicroOS snapshot. ✅
   ```sh
   mkdir /path/to/your/new/folder
   cd /path/to/your/new/folder
   curl -sL https://raw.githubusercontent.com/kube-hetzner/terraform-hcloud-kube-hetzner/master/packer-template/hcloud-microos-snapshots.pkr.hcl -o hcloud-microos-snapshots.pkr.hcl
   export HCLOUD_TOKEN="your_hcloud_token"
   packer init hcloud-microos-snapshots.pkr.hcl
   packer build hcloud-microos-snapshots.pkr.hcl
   hcloud context create <project-name>
   ```

How to Deploy the Infrastructure in this Repository?

### Prerequisites

1. Install OpenTofu version 1.6.0 or newer and Terragrunt version v0.52.0 or newer.
2. Update the `bucket` parameter in the root `terragrunt.hcl`. We use S3 as the Terraform backend for state storage, and S3 bucket names must be globally unique. The name currently in the file is already taken, so you will need to specify your own. Alternatively, you can set the `TG_BUCKET_PREFIX` environment variable to set a custom prefix.
3. Create projects in Hetzner Cloud and a zone in Hetzner DNS -> Generate API tokens -> Set environment variables or add token values directly in the `env.hcl` files for each environment.
4. Fill in other environment-specific values.
5. Configure your AWS credentials using one of the supported authentication mechanisms.

### Deploying a Single Module

1. Navigate to the module folder (e.g., `cd live/non-prod/eu-central/dev/cluster`).
2. Run `terragrunt plan` to preview the changes you are about to apply.
3. If the plan looks good, run `terragrunt apply`.

### Deploying All Modules in a Region

1. Navigate to the region folder (e.g., `cd live/non-prod/eu-central`).
2. Run `terragrunt run-all plan` to preview all the changes you are about to apply.
3. If the plan looks good, run `terragrunt run-all apply`.
How is the Code Organized in this Repository?

The code in this repository uses the following folder structure:

```
account
 └ _global
 └ region
    └ _global
    └ environment
       └ resource
```

Where:

* **Account**: At the top level are all your Hetzner accounts, such as `stage-account`, `prod-account`, `mgmt-account`, etc. If everything is deployed in one AWS account, there will only be one folder at the root level (e.g., `main-account`).

* **Region**: Each account will have one or more Hetzner regions, such as `eu-central`, `us-east`, and `us-west`, where resources are deployed. There may also be a `_global` folder that defines resources available in all regions.

* **Environment**: Each region will have one or more environments, such as `dev`, `stage`, etc. Typically, an environment corresponds to a single project in the cloud that isolates this environment from everything else in that account. There may also be a `_global` folder that defines resources available in all environments within that region.

* **Resource**: In each environment, you deploy all resources for that environment. Each module folder represents a resource in the cluster.

Creating and Using Root-Level Variables (Account)

In situations where you have multiple accounts or regions, you often need to pass common variables into each of your modules. Instead of copying and pasting the same variables into each terragrunt.hcl file in each region and environment, you can inherit them from inputs defined in the root terragrunt.hcl file.

Custom Terraform Modules for Creating Kubernetes Objects

The project includes a collection of custom Terraform modules. The modules are located in the modules folder. The current list of modules includes:

	•	grafana/prometheus
	•	percona-ps-operator
	•	percona-ps
	•	external-dns-hetzner

Feel free to use this translation for your documentation!