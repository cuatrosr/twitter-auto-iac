resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.rg_name
  node_resource_group = "nodeaks"
  location            = var.rg_location
  dns_prefix          = var.aks_dns_prefix
  tags                = var.aks_tags

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }
}
