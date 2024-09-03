data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}

resource "azurerm_role_definition" "aks_access" {
  name = "aks_access"
  scope = "/subscriptions/<sub id>"

  permissions {
    actions = [
      "Microsoft.ContainerService/managedClusters/*",
      "Microsoft.ContainerService/managedClusters/agentPools/*",
      "Microsoft.Network/networkInterfaces/*",
      "Microsoft.Network/virtualNetworks/*",
      "Microsoft.Compute/virtualMachineScaleSets/*"
    ]
    not_actions = []
  }
}

resource "azurerm_role_assignment" "cetha" {
  scope = "/subscriptions/2fac0f5e-befe-42b4-929d-e7d2c81351f3" #data.azurerm_subscription.primary.id
  role_definition_name = azurerm_role_definition.aks_access.name
  principal_id         = "9a8f6857-d73b-4725-aaea-e4e1b45e183c" #data.azurerm_client_config.example.object_id
}


