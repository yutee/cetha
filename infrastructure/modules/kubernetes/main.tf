
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
  chart      = "../../k8s/helm-chart/cetha-api"
  namespace  = "cetha"
  create_namespace = true
  dependency_update = true

  set {
    name  = "image.repository"
    value = "utibeokon/cheta:1.0"
  }

  depends_on = [helm_release.nginx_ingress]
}


data "kubernetes_service" "nginx_ingress" {
  metadata {
    name      = "nginx-ingress-controller"
    namespace = helm_release.nginx_ingress.namespace
  }

  depends_on = [helm_release.nginx_ingress]
}

# resource "null_resource" "wait_for_ip" {
#   provisioner "local-exec" {
#     command = "while [ -z $(kubectl get svc -n ${helm_release.nginx_ingress.metadata[0].namespace} ${data.kubernetes_service.nginx_ingress.metadata[0].name} -o jsonpath='{.status.loadBalancer.ingress[0].ip}') ]; do echo 'Waiting for IP...'; sleep 5; done"
#   }

#   depends_on = [helm_release.nginx_ingress]
# }
