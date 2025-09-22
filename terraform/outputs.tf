output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "postgres_fqdn" {
  value = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "database_service_url" {
  value = azurerm_linux_web_app.database_service.default_hostname
}

output "user_service_url" {
  value = azurerm_linux_web_app.user_service.default_hostname
}
