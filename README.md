<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | ~> 3.0.2 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.10.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.22.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | ~> 2.2.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_docker"></a> [docker](#provider\_docker) | ~> 3.0.2 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.10.1 |
| <a name="provider_template"></a> [template](#provider\_template) | ~> 2.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker_image.tenant](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [helm_release.ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.tenant](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [terraform_data.image-import](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [terraform_data.local](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [time_sleep.wait_for_ingress](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [template_file.tenant](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_domain"></a> [app\_domain](#input\_app\_domain) | Domain or subdomain for the APP | `string` | `"example.local"` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | application name | `string` | `"pyapp"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | cluster\_name | `string` | `"demo"` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Container Port | `number` | `5000` | no |
| <a name="input_docker-sock"></a> [docker-sock](#input\_docker-sock) | Docker socket | `string` | `"unix:///var/run/docker.sock"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | docker image tag | `string` | `"v1"` | no |
| <a name="input_kube_config_file"></a> [kube\_config\_file](#input\_kube\_config\_file) | Kube config file location | `string` | `"~/.kube/config"` | no |
| <a name="input_tenants"></a> [tenants](#input\_tenants) | List of tenants | `list(string)` | <pre>[<br>  "tenant-a"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tenant-ingresses"></a> [tenant-ingresses](#output\_tenant-ingresses) | FQDN for the tenants |
<!-- END_TF_DOCS -->