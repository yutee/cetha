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
    resource_group_name   = "terraformstatesRG"
    storage_account_name  = "terraformstate737"
    container_name        = "tfstateblob"
    key                   = "terraform_ci.tfstate"
  }

  required_version = ">= 1.1.0"
}

 # random provider
provider "random" {}

# azure provider
provider "azurerm" {
  features {}
  skip_provider_registration = true

  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
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
