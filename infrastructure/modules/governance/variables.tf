variable "tenant_id" {
  description = "The Tenant ID of your Azure Active Directory"
  type        = string
}

variable "subscription_id" {
  description = "The Subscription ID where the resources will be deployed"
  type        = string
}

variable "user_email" {
  description = "The user's login email (user principal name)"
  type        = string
  default     = "cethauser@utibeokon.me"
}

variable "password" {
  description = "Initial password for the user"
  type        = string
  default     = "StrongPassword123!"
}

variable "username" {
  description = "The user's display name"
  type        = string
  default     = "New User"
}

variable "mail_nickname" {
  description = "The user's mail nickname"
  type        = string
  default     = "newuser"
}