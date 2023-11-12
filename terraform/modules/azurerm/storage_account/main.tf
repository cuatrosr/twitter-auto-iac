resource "azurerm_storage_account" "sa" {
  name                     = "mysonarqubestorage"
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}
