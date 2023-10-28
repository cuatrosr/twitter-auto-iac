resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "autoinfraprod-rg"
}

resource "azurerm_storage_account" "sa" {
  name                     = "autoinfratwitterprod"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
