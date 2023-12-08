provider "azurerm" {
  features {}
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

module "postgres" {
  # source = "github.com/equinor/terraform-azurerm-postgres"
  source = "../.."

  database_name              = "example-db"
  server_name                = "psql-${random_id.example.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  administrator_login        = "psqladmin"
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
