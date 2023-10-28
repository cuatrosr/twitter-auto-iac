module "rg" {
  source = "./modules/azurerm_resource_group"
}

module "vnet" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm_virtual_network"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "snet" {
  depends_on = [module.rg, module.vnet]
  source     = "./modules/azurerm_subnet"
  rg_name    = module.rg.rg_name
  vnet_name  = module.vnet.vnet_name
}

module "pubip" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm_public_ip"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "ni" {
  depends_on  = [module.rg, module.snet, module.pubip]
  source      = "./modules/azurerm_network_interface"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
  sn_id       = module.snet.snet_id
  pubip_id    = module.pubip.pubip_id
}

module "nsg" {
  depends_on  = [module.module.rg]
  source      = "./modules/azurerm_network_security_group"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "nisga" {
  depends_on = [module.ni, module.nsg]
  source     = "./modules/azurerm_network_interface_security_group_association"
  ni_id      = module.ni.ni_id
  nsg_id     = module.nsg.nsg_id
}

module "cr" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm_container_registry"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "aks" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm_kubernetes_cluster"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}
