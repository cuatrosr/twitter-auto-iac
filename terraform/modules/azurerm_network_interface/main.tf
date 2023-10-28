resource "azurerm_network_interface" "ni" {
  name                = var.ni_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  tags                = var.ni_tags

  ip_configuration {
    name                          = var.ni_ip_name
    subnet_id                     = var.sn_id
    private_ip_address_allocation = var.privip_address_allocation
    public_ip_address_id          = var.pubip_id
  }
}
