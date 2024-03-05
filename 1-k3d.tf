resource "k3d_cluster" "k3d" {
  name    = var.cluster_name
  servers = 1
  agents  = 2
  image   = var.cluster_image

  kube_api {
    host_ip   = "0.0.0.0"
    host_port = 6443
  }

  port {
    host_port      = 443
    container_port = 443
    node_filters   = ["loadbalancer"]
  }

  port {
    host_port      = 80
    container_port = 80
    node_filters   = ["loadbalancer"]
  }

  k3d {
    disable_load_balancer = false
    disable_image_volume  = false
  }

  k3s {
    extra_args {
      arg          = "--disable=traefik"
      node_filters = ["server:0"]
    }
  }

  kubeconfig {
    update_default_kubeconfig = true
    switch_current_context    = true
  }
}

resource "docker_image" "tenant" {
  triggers = {
    "file_change" = sha1(file("app/app.py"))
  }
  depends_on = [k3d_cluster.k3d]
  name       = var.app_name
  build {
    context = "./app"
    tag     = ["${var.app_name}:${sha1(file("app/app.py"))}"]
    label = {
      app : var.app_name
    }
  }
}

resource "terraform_data" "image-import" {
  triggers_replace = sha1(file("app/app.py"))
  provisioner "local-exec" {
    command     = "k3d image import ${one(flatten(docker_image.tenant.build[*].tag))} -c ${var.cluster_name}"
    interpreter = ["bash", "-c"]
  }
  depends_on = [k3d_cluster.k3d, docker_image.tenant]
}

data "external" "getip" {
  program = ["bash", "${path.module}/getip.sh"]
}