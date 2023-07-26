data "template_file" "tenant" {
  for_each = toset(var.tenants)
  template = file("${path.module}/values/app.yaml")
  vars = {
    tenant     = each.value
    tag        = var.image_tag
    port       = var.container_port
    image      = var.app_name
    app_domain = var.app_domain
  }
}

resource "helm_release" "tenant" {
  depends_on       = [terraform_data.image-import, time_sleep.wait_for_ingress]
  for_each         = toset(var.tenants)
  name             = each.value
  chart            = "./helm-charts/python-multi-tenant"
  namespace        = each.value
  create_namespace = true
  values           = [data.template_file.tenant[each.key].rendered]
  cleanup_on_fail  = true
}
