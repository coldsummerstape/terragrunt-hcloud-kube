# Install Flux with Helm

Note: Using `flux_bootstrap_git` is the recommended approach but this is another option if we are unable to use `flux_bootstrap_git`.

The example demonstrates how to bootstrap a KinD cluster using the upstream [Flux helm chart](https://artifacthub.io/packages/helm/fluxcd-community/flux2).

It then leverages the upstream [flux2-sync helm chart](https://artifacthub.io/packages/helm/fluxcd-community/flux2-sync) to construct a `GitRepository` and `Kustomization` to sync manifests into the cluster.

However, using the Flux Helm chart is a better option when Flux needs to be installed without any bootstrap configuration.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | >= 6.1 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.12 |
| <a name="requirement_kind"></a> [kind](#requirement\_kind) | >= 0.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.27 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | >= 6.1 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.12 |
| <a name="provider_kind"></a> [kind](#provider\_kind) | >= 0.4 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.27 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_deploy_key.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [helm_release.flux2](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.flux2_sync](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kind_cluster.this](https://registry.terraform.io/providers/tehcyx/kind/latest/docs/resources/cluster) | resource |
| [kubernetes_namespace.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.ssh_keypair](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [tls_private_key.flux](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organization | `string` | `""` | no |
| <a name="input_github_repository"></a> [github\_repository](#input\_github\_repository) | GitHub repository | `string` | `""` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub token | `string` | `""` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->