variable "cluster_name" {
  type        = string
  description = "cluster_name"
  default     = "demo"
}

variable "app_domain" {
  type        = string
  description = "Domain or subdomain for the APP"
  default = "example.local"
}

variable "kube_config_file" {
  type        = string
  description = "Kube config file location"
  default     = "~/.kube/config"
}

variable "app_name" {
  type        = string
  description = "application name"
  default     = "pyapp"
}

variable "image_tag" {
  type        = string
  description = "docker image tag"
  default     = "v1"
}

variable "docker-sock" {
  type        = string
  description = "Docker socket"
  default     = "unix:///var/run/docker.sock"
}

variable "container_port" {
  type        = number
  description = "Container Port"
  default     = 5000
}
variable "tenants" {
  type        = list(string)
  description = "List of tenants"
  default     = ["tenant-a"]
}