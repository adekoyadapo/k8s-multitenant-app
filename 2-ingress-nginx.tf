resource "helm_release" "ingress" {
  depends_on = [terraform_data.local]
  name       = "nginx"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  version          = "4.6.1"
  values           = [file("values/ingress-nginx.yaml")]
}

resource "time_sleep" "wait_for_ingress" {
  create_duration = "50s"

  depends_on = [helm_release.ingress]
}