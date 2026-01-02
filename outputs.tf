output "database_id" {
  description = "The ID of this PostgreSQL database."
  value       = azurerm_postgresql_database.this.id
}

output "database_name" {
  description = "The name of this PostgreSQL database."
  value       = azurerm_postgresql_database.this.name
}

output "server_id" {
  description = "The ID of this PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.this.id
}

output "server_name" {
  description = "The name of this PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.this.name
}

output "administrator_login" {
  description = "The administrator login of this PostgreSQL server."
  value       = azurerm_postgresql_flexible_server.this.administrator_login
}
