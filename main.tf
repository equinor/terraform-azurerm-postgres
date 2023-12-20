resource "random_password" "this" {
  length      = 128
  lower       = true
  upper       = true
  numeric     = true
  special     = true
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
}

resource "azurerm_postgresql_server" "this" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location

  administrator_login          = var.administrator_login
  administrator_login_password = random_password.this.result

  sku_name   = var.sku_name
  version    = "11"
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled

  # This property is currently still in development and not supported by Microsoft.
  # It is strongly suggested to leave this value false as not doing so can lead to unclear error messages.
  infrastructure_encryption_enabled = false

  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

  tags = var.tags

  lifecycle {
    ignore_changes = [
      # Allow administrator login password to be rotated outside of Terraform.
      administrator_login_password
    ]
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_postgresql_active_directory_administrator" "this" {
  count = var.active_directory_administrator != null ? 1 : 0

  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.this.name
  login               = var.active_directory_administrator["login"]
  object_id           = var.active_directory_administrator["object_id"]
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_postgresql_firewall_rule" "this" {
  for_each = var.firewall_rules

  name                = each.value["name"]
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.this.name
  start_ip_address    = each.value["start_ip_address"]
  end_ip_address      = each.value["end_ip_address"]
}

resource "azurerm_postgresql_database" "this" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.this.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = azurerm_postgresql_server.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false
  }
}
