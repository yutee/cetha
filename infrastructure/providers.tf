terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.70.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "= 2.12.1"
    }
  }

  # will need this to run ci/cd pipeline
  backend "azurerm" {
    resource_group_name   = "tfstate"
    storage_account_name  = "cethatfstate"
    container_name        = "tfstate"
    key                   = "terraform.tfstate"
  }

  required_version = ">= 1.1.0"
}

 # random provider
provider "random" {}

# azure provider
provider "azurerm" {
  features {}
}

# kubernetes provider
provider "kubernetes" {
  host                   = module.aks.azurerm_kubernetes_cluster.kube_config.0.host
  client_certificate     = base64decode(module.aks.azurerm_kubernetes_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(module.aks.azurerm_kubernetes_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(module.aks.azurerm_kubernetes_cluster.kube_config.0.cluster_ca_certificate)
}

# helm provider
provider "helm" {
  kubernetes {
      host                   = module.aks.azurerm_kubernetes_cluster.kube_config.0.host
      client_certificate     = base64decode(module.aks.azurerm_kubernetes_cluster.kube_config.0.client_certificate)
      client_key             = base64decode(module.aks.azurerm_kubernetes_cluster.kube_config.0.client_key)
      cluster_ca_certificate = base64decode(module.aks.azurerm_kubernetes_cluster.kube_config.0.cluster_ca_certificate)
  }
}
