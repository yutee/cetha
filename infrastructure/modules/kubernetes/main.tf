
# resources to be deployed in the kubernetes cluster
# ingress controller
resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.1.3"

  create_namespace = true

  values = [
    <<EOF
controller:
  service:
    annotations:
      service.beta.kubernetes.io/azure-load-balancer-resource-group: "${var.rg_name}"
      service.beta.kubernetes.io/azure-load-balancer-internal: "true"
  admissionWebhooks:
    enabled: true
  metrics:
    enabled: true
EOF
  ]
}

# cetha api
resource "helm_release" "cetha_api" {
  name       = "cetha-api"
  chart      = "../k8s/helm-chart/cetha-api"
  dependency_update = true
  wait    = true
  timeout = 600

  depends_on = [helm_release.nginx_ingress]
}

# monitoring 
resource "helm_release" "prometheus_stack" {
  name       = "prometheus-stack"
  namespace  = "monitoring"
  create_namespace = true
  chart      = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "45.6.0"
  wait    = true
  timeout = 600

  set {
    name  = "grafana.adminPassword"
    value = "admin"
  }
}