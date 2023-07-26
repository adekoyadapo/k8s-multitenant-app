output "tenant-ingresses" {
  description = "FQDN for the tenants"
  value       = { for i in toset(var.tenants) : i => "${i}.${var.app_domain}" }
}