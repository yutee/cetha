output "network_vnet_id" {
  value = module.network.vnet_id
}

output "aks_cluster_name" {
  value = module.aks.aks_cluster_name
}

output "rg_name" {
  value = module.rg.rg_name
}

output "nginx_ingress_ip" {
  value = module.kubernetes.nginx_ingress_ip
}