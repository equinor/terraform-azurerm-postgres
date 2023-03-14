variable "database_name" {
  description = "The name of this PostgreSQL database."
  type        = string
}

variable "server_name" {
  description = "The name of this PostgreSQL server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login of this PostgreSQL server."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for this PostgreSQL server (tier + family + cores)."
  type        = string
  default     = "B_Gen5_1"
}

variable "storage_mb" {
  description = "The max storage allowed for this PostgreSQL server."
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "The number of days that backups should be retained for this PostgreSQL server."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Should geo-redundant backups be enabled for this PostgreSQL server?"
  type        = bool
  default     = false
}

variable "auto_grow_enabled" {
  description = "Should storage auto grow be enabled for this PostgreSQL server?"
  type        = bool
  default     = true # ???
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for this PostgreSQL server?"
  type        = bool
  default     = true
}

variable "ssl_enforcement_enabled" {
  description = "Should SSL be enforced on connections?"
  type        = bool
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "The minimum TLS version to support on this PostgreSQL server."
  type        = string
  default     = "TLS1_2"
}

variable "active_directory_administrator" {
  description = "An Active Directory administrator to configure for this PostgreSQL server."

  type = object({
    login     = string
    object_id = string
  })

  default = null
}

variable "firewall_rules" {
  description = "A map of firewall rules for this PostgreSQL server."

  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))

  default = {
    "azure" = {
      name             = "AllowAllWindowsAzureIps"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["PostgreSQLLogs"]
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
