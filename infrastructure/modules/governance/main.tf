provider "azuread" {
  tenant_id = var.tenant_id
}

resource "azuread_user" "aks_user" {
  user_principal_name = var.user_email
  display_name        = var.username
  mail_nickname       = var.mail_nickname
  password            = var.password
  force_password_change = true  # user must change password onlogin
}

resource "azurerm_role_assignment" "example_assignment" {
  scope                = data.azurerm_subscription.primary.id  # subscription level asignment
  role_definition_name = "Contributor"  # built-in Reader role, allows to manage resources, but not assign other roles
  principal_id         = azuread_user.aks_user.object_id
}

# Data Source to Get the Subscription ID
data "azurerm_subscription" "primary" {
  subscription_id = var.subscription_id
}




