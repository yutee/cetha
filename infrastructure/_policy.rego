package terraform.analysis.v1

# rule to deny access to port 22
deny[msg] {
  input.resource_changes[_].type == "azurerm_network_security_rule"
  input.resource_changes[_].change.after.destination_port_range == "22"
  msg = "Access to port 22 (SSH) is not allowed."
}