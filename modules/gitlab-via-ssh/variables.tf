variable "gitlab_token" {
  description = "The GitLab token to use for authenticating against the GitLab API."
  sensitive   = true
  type        = string
  default     = ""
}

variable "gitlab_project" {
  description = "The GitLab project to use for creating the GitLab project."
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Имя Kubernetes кластера"
  type        = string
  default     = "flux-default"
}
