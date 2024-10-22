resource "helm_release" "rabbitmq" {
  namespace        = var.namespace
  create_namespace = true
  name             = var.release_name
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "rabbitmq"
  version          = var.rabbitmq_chart_version

  # Helm chart deployment can sometimes take longer than the default 5 minutes
  timeout = var.timeout_seconds

  # If values file specified by the var.values_file input variable exists then apply the values from this file
  # else apply the default values from the chart
  values = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : ""]

  set {
    name  = "auth.password"
    value = var.rabbitmq_admin_password
  }

  set {
    name  = "persistence.storageClass"
    value = var.rabbitmq_storageclass_name
  }

  set {
    name  = "persistence.size"
    value = var.rabbitmq_storage_size
  }

  set {
    name  = "node.kubernetes.io/role"
    value = "worker"
  }

  set {
    name  = "ingress.hostname"
    value = var.rabbitmq_url
  }

  set {
    name  = "ingress.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = var.rabbitmq_url # Используем переменную для хоста
  }

}
