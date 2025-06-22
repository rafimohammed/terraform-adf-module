terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
  }
}


resource "azurerm_storage_account" "this" {
  name = "${replace(var.resource_group_name, "-", "")}store"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = {
    environment = "quest"
  }
}

resource "azurerm_storage_container" "this" {
  name                  = "pipeline-input"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}