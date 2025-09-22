# database-service web app
resource "azurerm_linux_web_app" "database_service" {
  name                = "${var.prefix}-database"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_app_service_plan.asp.id

  site_config {
    # container image to be replaced after you push to ACR (we use latest tag)
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/database-service:latest"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password

    "SPRING_DATASOURCE_URL"           = "jdbc:postgresql://${azurerm_postgresql_flexible_server.postgres.fqdn}:5432/${var.postgres_db_name}"
    "SPRING_DATASOURCE_USERNAME"      = var.postgres_admin_username
    "SPRING_DATASOURCE_PASSWORD"      = var.postgres_admin_password

    # optional
    "WEBSITES_PORT" = "8080"
  }

  tags = {
    environment = "demo"
  }
}

# user-service web app
resource "azurerm_linux_web_app" "user_service" {
  name                = "${var.prefix}-user"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  service_plan_id     = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/user-service:latest"
  }

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = "https://${azurerm_container_registry.acr.login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password

    # database-service URL (will be available after DB app deployed)
    "DATABASE_SERVICE_BASE_URL" = "https://${azurerm_linux_web_app.database_service.default_hostname}/api"
    "WEBSITES_PORT" = "8080"
  }

  tags = {
    environment = "demo"
  }
}
