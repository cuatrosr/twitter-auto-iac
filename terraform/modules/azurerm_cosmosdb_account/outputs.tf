output "db_name" {
  value = azurerm_cosmosdb_account.db.name
}

output "db_of_type" {
  value = azurerm_cosmosdb_account.db.offer_type
}

output "db_kind" {
  value = azurerm_cosmosdb_account.db.kind
}
