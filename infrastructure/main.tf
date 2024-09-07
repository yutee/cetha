# root main.tf file to call all modules

module "rg" {
  source              = "./modules/rg"
}

module "governance" {
  source              = "./modules/governance"
  tenant_id           = var.tenant_id
  subscription_id     = var.subscription_id
  create_user         = false
}

module "network" {
  source              = "./modules/network"
  rg_name             = module.rg.rg_name
  rg_location         = module.rg.rg_location
  random_integer      = module.rg.random_integer 
  vnet_name           = "cetha-VNET" 
  vnet_cidr           = ["107.224.0.0/12"] 
  subnet_name         = "cetha-subnet"
  subnet_cidr         = ["107.224.0.0/16"]
  nsg_name            = "cetha-NSG"
  depends_on          = [ module.rg ]
}

module "aks" {
  source              = "./modules/aks"
  rg_name             = module.rg.rg_name
  rg_location         = module.rg.rg_location
  aks_name            = "cetha-api-AKS"
  dns_prefix          = "cetha-api"
  node_pool_name      = "default"
  node_count          = 1
  vm_size             = "Standard_B2ms"
  os_disk_size_gb     = 50
  subnet_id           = module.network.subnet_id
  depends_on          = [ module.network ]
}

module "kubernetes" {
  source              = "./modules/kubernetes"
  rg_name             = module.rg.rg_name
  depends_on          = [ module.aks ]
}