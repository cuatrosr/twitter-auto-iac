output "pubip_id" {
  value = azurerm_public_ip.pubip.id
}

output "pubip_address" {
  value = azurerm_public_ip.pubip.ip_address
}
