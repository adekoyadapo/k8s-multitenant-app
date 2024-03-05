data "template_file" "tenant" {
  for_each = toset(var.tenants)
  template = file("${path.module}/values/app.yaml")
  vars = {
    tenant     = each.value
    tag        = sha1(file("app/app.py"))
    port       = var.container_port
    image      = var.app_name
    app_domain = "${data.external.getip.result.sslip_io}"
  }
}

resource "helm_release" "tenant" {
  for_each         = toset(var.tenants)
  name             = each.value
  chart            = "./helm-charts/python-multi-tenant"
  namespace        = each.value
  create_namespace = true
  values           = [data.template_file.tenant[each.key].rendered]
  cleanup_on_fail  = true
  depends_on       = [terraform_data.image-import, docker_image.tenant]
}
