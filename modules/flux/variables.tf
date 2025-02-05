variable "gitlab_token" {
  description = "GitLab token"
  sensitive   = true
  type        = string
  default     = ""
}

variable "gitlab_org" {
  description = "GitLab organization"
  type        = string
  default     = ""
}

variable "gitlab_repository" {
  description = "GitLab repository"
  type        = string
  default     = ""
}
