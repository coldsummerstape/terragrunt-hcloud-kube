resource "kubernetes_secret" "hetzner_credentials" {
  metadata {
    name      = "hetzner-credentials-certmanager"
    namespace = "cert-manager"
  }
  data = {
    "api-key" = base64encode(var.hetzner_api_dns_key)
  }
  type = "Opaque"
}

resource "helm_release" "cert_manager_webhook_hetzner" {
  namespace        = "cert-manager"
  create_namespace = false
  name             = "cert-manager-webhook-hetzner"
  repository       = "https://vadimkim.github.io/cert-manager-webhook-hetzner"
  chart            = "cert-manager-webhook-hetzner"
  version          = "1.3.1"
  timeout          = "800"
  values           = [fileexists("${path.root}/${var.values_file}") == true ? file("${path.root}/${var.values_file}") : ""]
}
