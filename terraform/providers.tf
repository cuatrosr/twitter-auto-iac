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
