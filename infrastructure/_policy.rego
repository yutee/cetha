package terraform.analysis.v1

# rule to deny access to port 22
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "azurerm_network_security_group"
  rule := resource.change.after.security_rules[_]
  rule.destination_port_range == "22"
  msg = sprintf("Access to port 22 (SSH) is not allowed in NSG %v.", [resource.address])
}