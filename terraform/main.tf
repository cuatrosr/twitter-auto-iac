module "rg" {
  source = "./modules/azurerm_resource_group"
}

module "vnet" {
  source      = "./modules/azurerm_virtual_network"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "snet" {
  source    = "./modules/azurerm_subnet"
  rg_name   = module.rg.rg_name
  vnet_name = module.vnet.vnet_name
}

module "ni" {
  source = "./modules/azurerm_network_interface"
}

module "cr" {
  source      = "./modules/azurerm_container_registry"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}
