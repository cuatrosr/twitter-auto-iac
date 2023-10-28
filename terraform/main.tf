module "rg" {
  source = "./modules/azurerm/resource_group"
}

module "vnet" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm/virtual_network"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "snet" {
  depends_on = [module.rg, module.vnet]
  source     = "./modules/azurerm/subnet"
  rg_name    = module.rg.rg_name
  vnet_name  = module.vnet.vnet_name
}

module "pubip" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm/public_ip"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "ni" {
  depends_on  = [module.rg, module.snet, module.pubip]
  source      = "./modules/azurerm/network_interface"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
  sn_id       = module.snet.snet_id
  pubip_id    = module.pubip.pubip_id
}

module "nsg" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm/network_security_group"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "nisga" {
  depends_on = [module.ni, module.nsg]
  source     = "./modules/azurerm/network_interface_security_group_association"
  ni_id      = module.ni.ni_id
  nsg_id     = module.nsg.nsg_id
}

module "cr" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm/container_registry"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "mongo_db" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm/cosmosdb_account"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "aks" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm/kubernetes_cluster"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "hpa_deployment" {
  source = "./modules/kubernetes/deployment"
}

module "hpa" {
  depends_on = [module.aks, module.rg]
  source     = "./modules/kubernetes/horizontal_pod_autoscaler"
}

module "hpa_service" {
  source = "./modules/kubernetes/service"
}

module "load_generator" {
  source = "./modules/kubernetes/pod"
}
