output "nginx_ingress_ip" {
  value = length(data.kubernetes_service.nginx_ingress.status) > 0 ? data.kubernetes_service.nginx_ingress.status[0].load_balancer[0].ingress[0].ip : null
}
