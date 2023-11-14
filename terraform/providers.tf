terraform {
  backend "azurerm" {
    resource_group_name  = var.state_resource_group_name
    storage_account_name = var.state_storage_account_name
    container_name       = "auto-twitter"
    key                  = "auto-terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.11.0"
    }
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_kubernetes_cluster" "cluster" {
  depends_on = [
    module.aks,
    module.rg
  ]
  name                = module.aks.aks_name
  resource_group_name = module.rg.rg_name
}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host = data.azurerm_kubernetes_cluster.cluster.kube_config.0.host

    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
  }
}
