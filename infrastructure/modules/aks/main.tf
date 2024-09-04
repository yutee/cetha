resource "azurerm_kubernetes_cluster" "aks" {
  name                = "cetha-api-AKS"
  location            = var.rg_location
  resource_group_name = var.rg_name
  dns_prefix          = "cetha-api"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_B2ms"
    os_disk_size_gb = 50
    temporary_name_for_rotation = "tempdefault"
    # vnet_subnet_id  = var.subnet_id
    # enable_node_public_ip = true      # bad for security
    upgrade_settings {
      max_surge       = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = azurerm_kubernetes_cluster.aks.name
  resource_group_name = azurerm_kubernetes_cluster.aks.resource_group_name
}