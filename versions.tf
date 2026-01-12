terraform {
  required_version = ">= 1.12.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }

    azurerm = {
      source = "hashicorp/azurerm"
      ### Required to support azurerm_postgresql_flexible_server resource with postgresql version 18
      version = ">= 4.55.0"
    }
  }
}
