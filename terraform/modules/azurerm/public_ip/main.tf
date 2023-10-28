resource "azurerm_public_ip" "pubip" {
  name                = var.pubip_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  allocation_method   = var.pubip_allocation_method
  tags                = var.pubip_tags
}
