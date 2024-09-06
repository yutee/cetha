variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rg_location" {
  description = "Location of resources"
  type        = string
}

variable "random_integer" {
  description = "Random integer"
  type        = number
}

variable "vnet_name" {}
variable "vnet_cidr" {}
variable "subnet_name" {}
variable "subnet_cidr" {}
variable "nsg_name" {}