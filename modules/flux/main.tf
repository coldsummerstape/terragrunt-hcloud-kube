# ==========================================
# Add deploy token to Gitlab repository
# ==========================================

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "gitlab_deploy_key" "this" {
  project  = 60892314
  title    = "Flux"
  key      = tls_private_key.flux.public_key_openssh
  can_push = true
}

resource "flux_bootstrap_git" "this" {
  depends_on         = [gitlab_deploy_key.this]
  embedded_manifests = true
  path               = "clusters/development"
}
