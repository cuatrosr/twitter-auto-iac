resource "azurerm_storage_share" "ss" {
  name                 = "mysonarqubedata"
  quota                = 1
  storage_account_name = var.sa_name
}
