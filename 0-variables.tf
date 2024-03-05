variable "cluster_name" {
  type        = string
  description = "cluster_name"
  default     = "demo"
}

variable "cluster_image" {
  type        = string
  description = "Cluster iamge"
  default     = "rancher/k3s:v1.27.4-k3s1"
}

variable "app_name" {
  type        = string
  description = "application name"
  default     = "pyapp"
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