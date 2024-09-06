output "resource_group_name" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
  
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "azurerm_kubernetes_cluster" {
  value = data.azurerm_kubernetes_cluster.aks
}

