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

module "pubip" {
  source      = "./modules/azurerm_public_ip"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "ni" {
  source      = "./modules/azurerm_network_interface"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
  sn_id       = module.snet.snet_id
  pubip_id    = module.pubip.pubip_id
}

module "nsg" {
  source      = "./modules/azurerm_network_security_group"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "nisga" {
  source = "./modules/azurerm_network_interface_security_group_association"
  ni_id  = module.ni.ni_id
  nsg_id = module.nsg.nsg_id
}

module "cr" {
  source      = "./modules/azurerm_container_registry"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}
module "mongo_db" {
  source      = "./modules/azurerm_cosmodb_account"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

