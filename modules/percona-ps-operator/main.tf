resource "kubernetes_namespace" "percona-ps-operator" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "percona-ps-operator" {
  namespace        = var.namespace
  create_namespace = true
  name             = var.release_name
  repository       = "https://percona.github.io/percona-helm-charts/"
  chart            = "ps-operator"
  version          = var.percona_ps_operator_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

}
