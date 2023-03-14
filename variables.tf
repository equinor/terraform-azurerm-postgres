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

variable "sku_name" {
  description = "The SKU name for this PostgreSQL server (tier + family + cores)."
  type        = string
  default     = "B_Gen4_1"
}

variable "storage_mb" {
  description = "The max storage allowed for this PostgreSQL server."
  type        = number
  default     = 5120
}

variable "version" {
  description = "The version of PostgreSQL to use."
  type        = string
  default     = "11"
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

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
