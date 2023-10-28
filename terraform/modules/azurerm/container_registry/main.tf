resource "azurerm_container_registry" "cr" {
  name                = var.cr_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  sku                 = var.cr_sku
  admin_enabled       = var.cr_admin_enabled
  tags                = var.cr_tags
}
