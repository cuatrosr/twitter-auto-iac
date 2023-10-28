output "ni_id" {
  value = azurerm_network_interface.ni.id
}

output "ni_private_ip" {
  value = azurerm_network_interface.ni.private_ip_address
}