provider "azurerm" {
  features {}
}

locals {
  tags = {
    "Environment" = "Testing"
  }
}

resource "random_id" "example" {
  byte_length = 8
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.3.1"

  workspace_name      = "log-${random_id.example.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

data "azurerm_client_config" "current" {}

module "postgres" {
  # source = "github.com/equinor/terraform-azurerm-postgres"
  source = "../.."

  database_name                    = "example-db"
  server_name                      = "psql-${random_id.example.hex}"
  resource_group_name              = var.resource_group_name
  location                         = var.location
  administrator_login              = "psqladmin"
  log_analytics_workspace_id       = module.log_analytics.workspace_id
  sku_name                         = "B_Gen5_1"
  storage_mb                       = 5120
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  auto_grow_enabled                = true
  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  active_directory_administrator = {
    login     = "adadmin"
    object_id = data.azurerm_client_config.current.object_id
  }

  firewall_rules = {
    "azure" = {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }

  tags = local.tags
}
