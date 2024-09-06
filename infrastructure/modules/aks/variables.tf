variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "Location of resources"
  type        = string
}

variable "aks_name" {}
variable "dns_prefix" {}

variable "node_pool_name" {}
variable "node_count" {}
variable "vm_size" {}
variable "os_disk_size_gb" {}
variable "subnet_id" {}