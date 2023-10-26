module "rg" {
  source = "./modules/azurerm_resource_group"
}

module "vnet" {
  source      = "./modules/azurerm_virtual_network"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "cr" {
  source      = "./modules/azurerm_container_registry"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}
