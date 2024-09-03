# root main.tf file to call all modules

module "rg" {
  source              = "./modules/rg"
}

# module "governance" {
#   source              = "./modules/governance"
#   rg_name             = module.rg.rg_name
#   role_name           = "cetha-role"
#   depends_on          = [ module.rg ]
# }

module "network" {
  source              = "./modules/network"
  rg_name             = module.rg.rg_name
  rg_location         = module.rg.rg_location
  random_integer      = module.rg.random_integer 
  depends_on          = [ module.rg ]
}

module "aks" {
  source              = "./modules/aks"
  rg_name             = module.rg.rg_name
  rg_location         = module.rg.rg_location
  depends_on          = [ module.network ]
}

module "kubernetes" {
  source              = "./modules/kubernetes"
  depends_on          = [ module.aks ]
}