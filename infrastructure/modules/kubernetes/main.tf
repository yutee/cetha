
# resources to be deployed in the kubernetes cluster
# ingress controller
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  namespace  = "nginx-ingress"
  create_namespace = true
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.7.1"
  wait    = true
  timeout = 600

  set {
    name  = "controller.replicaCount"
    value = "1"
  }
}

# api helm chart
resource "helm_release" "cetha_api" {
  name       = "cetha-api"
  chart      = "../k8s/helm-chart/cetha-api"
  dependency_update = true
  wait    = true
  timeout = 600

  depends_on = [helm_release.nginx_ingress]
}