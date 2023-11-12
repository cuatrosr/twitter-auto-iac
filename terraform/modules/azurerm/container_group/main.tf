resource "azurerm_container_group" "cg" {
  name                = var.cg_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  ip_address_type     = "Public"
  dns_name_label      = "my-sonarqube"
  os_type             = "Linux"
  restart_policy      = "OnFailure"

  exposed_port {
    port     = 9000
    protocol = "TCP"
  }

  container {
    name   = "sonarqube"
    image  = "sonarqube:9.2.0-community"
    cpu    = "1"
    memory = "4"

    ports {
      port     = 9000
      protocol = "TCP"
    }

    volume {
      name                 = "sonarqube-data"
      mount_path           = "/opt/sonarqube/data"
      read_only            = false
      share_name           = var.ss_name
      storage_account_name = var.sa_name
      storage_account_key  = var.sa_key
    }
    volume {
      name                 = "sonarqube-extensions"
      mount_path           = "/opt/sonarqube/extensions"
      read_only            = false
      share_name           = var.ss_name
      storage_account_name = var.sa_name
      storage_account_key  = var.sa_key
    }
    volume {
      name                 = "sonarqube-logs"
      mount_path           = "/opt/sonarqube/logs"
      read_only            = false
      share_name           = var.ss_name
      storage_account_name = var.sa_name
      storage_account_key  = var.sa_key
    }
  }
}
