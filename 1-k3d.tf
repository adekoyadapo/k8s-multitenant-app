resource "terraform_data" "local" {
  provisioner "local-exec" {
    command     = "./deploy.sh ${var.cluster_name}"
    interpreter = ["bash", "-c"]
  }
  provisioner "local-exec" {
    when        = destroy
    command     = "./deploy.sh cleanup"
    interpreter = ["bash", "-c"]
  }
}

resource "docker_image" "tenant" {
  depends_on = [terraform_data.local]
  name       = var.app_name
  build {
    context = "./app"
    tag     = ["${var.app_name}:${var.image_tag}"]
    label = {
      app : var.app_name
    }
  }
}

resource "terraform_data" "image-import" {
  provisioner "local-exec" {
    command     = "k3d image import ${one(flatten(docker_image.tenant.build[*].tag))} -c ${var.cluster_name}"
    interpreter = ["bash", "-c"]
  }
}
