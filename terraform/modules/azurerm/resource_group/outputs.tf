output "rg_id" {
  description = "Resource group Id"
  value       = azurerm_resource_group.rg.id
}

output "rg_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.rg.name
}

output "rg_location" {
  description = "Resource group location"
  value       = azurerm_resource_group.rg.location
}
