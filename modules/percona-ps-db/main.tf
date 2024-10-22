resource "helm_release" "percona-pxc-db" {
  namespace        = var.namespace
  create_namespace = true
  name             = var.release_name
  repository       = "https://percona.github.io/percona-helm-charts/"
  chart            = "ps-db"
  version          = var.percona_ps_db_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds
}
