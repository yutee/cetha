resource "random_integer" "number" {
  min = 10
  max = 99 
}

resource "azurerm_resource_group" "rg" {
  name     = "cetha-${random_integer.number.id}-RG"
  location = "East US 2"

  tags = {
    environment = "cetha"
  }
}