resource "kubernetes_namespace" "external_dns_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "hetzner_credentials" {
  depends_on = [kubernetes_namespace.external_dns_namespace]

  metadata {
    name      = "hetzner-credentials-external-dns"
    namespace = "external-dns-hetzner"
  }

  data = {
    "api-key" = var.hetzner_api_dns_key
  }

  type = "Opaque"
}

resource "helm_release" "external-dns-hetzner" {
  depends_on       = [kubernetes_secret.hetzner_credentials]
  namespace        = var.namespace
  create_namespace = true
  name             = var.release_name
  repository       = "oci://registry-1.docker.io/bitnamicharts"
  chart            = "external-dns"
  version          = var.external_dns_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  # If values file specified by the var.values_file input variable exists then apply the values from this file
  # else apply the default values from the chart
  values = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : ""]
}
