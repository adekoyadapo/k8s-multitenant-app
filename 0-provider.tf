terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.10.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.22.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path    = var.kube_config_file
    config_context = "k3d-${var.cluster_name}"
  }
}

provider "kubectl" {
  config_path    = var.kube_config_file
  config_context = "k3d-${var.cluster_name}"
}

provider "docker" {
  host = var.docker-sock
}

provider "kubernetes" {
  config_path    = var.kube_config_file
  config_context = "k3d-${var.cluster_name}"
}