resource "helm_release" "portainer" {
  namespace        = var.namespace
  create_namespace = true
  name             = var.release_name
  repository       = "https://portainer.github.io/k8s"
  chart            = "portainer"
  version          = var.portainer_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  # If values file specified by the var.values_file input variable exists then apply the values from this file
  # else apply the default values from the chart
  values = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : ""]
}
