output "cr_id" {
  value = azurerm_container_registry.cr.id
}

output "cr_name" {
  value = azurerm_container_registry.cr.name
}

output "cr_login_server" {
  value = azurerm_container_registry.cr.login_server
}

output "cr_admin_username" {
  value = azurerm_container_registry.cr.admin_username
}

output "cr_admin_password" {
  value     = azurerm_container_registry.cr.admin_password
  sensitive = true
}
