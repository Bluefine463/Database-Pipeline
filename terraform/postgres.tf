resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = var.postgres_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  version             = "15"
  administrator_login = var.postgres_admin_username
  administrator_password = var.postgres_admin_password

  sku_name = "Standard_B1ms"

  storage {
    storage_mb = 32768
  }

  backup {
    backup_retention_days = 7
  }

  high_availability {
    mode = "Disabled"
  }

  network {
    public_network_access_enabled = true
  }

  tags = {
    environment = "demo"
  }
}

resource "azurerm_postgresql_flexible_server_database" "appdb" {
  name                = var.postgres_db_name
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_postgresql_flexible_server.postgres.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}
