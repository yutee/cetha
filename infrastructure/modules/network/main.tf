resource "azurerm_virtual_network" "vnet" {
  name                = "cetha-VNET"
  address_space       = ["10.0.0.0/16"]
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "subnet" {
  name                 = "cetha-subnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "nat_gateway_ip" {
  name                = "nat-public-ip"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = "cetha-nat-gateway"
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku_name            = "Standard"
  idle_timeout_in_minutes = 5
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet_association" {
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}

# resource "azurerm_firewall" "firewall" {
#   name                = "cetha-FW"
#   location            = var.rg_location
#   resource_group_name = var.rg_name
#   sku_name            = "AZFW_VNet"
#   sku_tier            = "Basic"
# }

# resource "azurerm_firewall_policy" "firewall_policy" {
#   name                = "cetha-firewall-policy"
#   resource_group_name = var.rg_name
#   location            = var.rg_location
# }

# resource "azurerm_firewall_network_rule_collection" "allow_ingress_ports" {
#   name                = "allow-ingress-ports"
#   resource_group_name = var.rg_name
#   azure_firewall_name = azurerm_firewall.firewall.name
#   priority            = 101
#   action              = "Allow"

#   rule {
#     name                     = "allow-http"
#     protocols                 = ["TCP"]
#     source_addresses         = ["*"]
#     destination_addresses    = ["10.0.0.0/24"]  // Your subnet or specific IP
#     destination_ports        = ["80"]
#   }
# }
