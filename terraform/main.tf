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

module "helm" {
  depends_on = [module.aks]
  source     = "./modules/helm/release"
}

resource "mongodbatlas_cluster" "test" {
  project_id   = "656611ec1f93e97aa25af3cb"
  name         = "test"
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = "US_EAST"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.2"

  # Provider Settings "block"
  provider_name               = "AZURE"
  provider_disk_type_name     = "P6"
  provider_instance_size_name = "M30"
}
