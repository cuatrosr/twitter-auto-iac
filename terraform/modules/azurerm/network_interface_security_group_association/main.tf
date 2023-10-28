resource "azurerm_network_interface_security_group_association" "nisga" {
  network_interface_id      = var.ni_id
  network_security_group_id = var.nsg_id
}
