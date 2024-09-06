
resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.11.2"

  create_namespace = true
  count = 0
}

# cetha api
resource "helm_release" "cetha_api" {
  name       = "cetha-api"
  chart      = "../k8s/helm-chart/cetha-api"
  dependency_update = true
}

# monitoring 
resource "helm_release" "prometheus_stack" {
  name       = "prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true
  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "45.6.0"

  set {
    name  = "grafana.adminPassword"
    value = "admin"
  }
  count = 0
}