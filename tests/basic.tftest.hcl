mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "basic_defaults" {
  command = plan

  variables {
    database_name              = run.setup_tests.database_name
    server_name                = run.setup_tests.server_name
    administrator_login        = run.setup_tests.administrator_login
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = azurerm_postgresql_database.this.name == run.setup_tests.database_name
    error_message = "PostgreSQL database name should match the setup test database name"
  }

  assert {
    condition     = azurerm_postgresql_database.this.resource_group_name == run.setup_tests.resource_group_name
    error_message = "PostgreSQL database resource group should match the setup test resource group"
  }

  assert {
    condition     = azurerm_postgresql_flexible_server.this.location == run.setup_tests.location
    error_message = "PostgreSQL database server location should match the setup test location"
  }
}
