resource "kubernetes_namespace" "external_secrets_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "external-secrets" {
  namespace        = var.namespace
  create_namespace = true
  name             = var.release_name
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  version          = var.external_secrets_chart_version
  timeout          = var.timeout_seconds
  values           = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : ""]
}
