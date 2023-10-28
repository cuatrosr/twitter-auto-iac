resource "azurerm_network_interface" "ni" {
  name                            = "${var.name}-ni"
  location                        = var.rg_location
  resource_group_name             = var.rg_name

  ip_configuration {
    name                          = "${var.name}-ni-ic"
    subnet_id                     = var.sn_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pi.id
  }
}