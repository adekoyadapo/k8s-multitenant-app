output "endpoints" {
  description = "Tenant FQDN"
  value       = { for i, j in data.template_file.tenant : i => "${i}.${j.vars.app_domain}" }
}