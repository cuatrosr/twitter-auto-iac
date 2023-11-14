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

module "sa" {
  depends_on  = [module.rg]
  source      = "./modules/azurerm/storage_account"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
}

module "ss" {
  depends_on = [module.sa]
  source     = "./modules/azurerm/storage_share"
  sa_name    = module.sa.sa_name
}

module "cg" {
  depends_on  = [module.rg, module.sa, module.ss]
  source      = "./modules/azurerm/container_group"
  rg_name     = module.rg.rg_name
  rg_location = module.rg.rg_location
  ss_name     = module.ss.ss_name
  sa_name     = module.sa.sa_name
  sa_key      = module.sa.sa_key
}

resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  namespace  = "monitoring"
  version    = "36.2.0"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}
