package terraform

deny[port] {
  some r
  r = input.resources["azurerm_network_security_group"].values.ingress_ports[_] == port
  port == 22  # denies access to ssh port
}