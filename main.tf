provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

resource "azurerm_role_definition" "example_role" {
  name        = "example_role"
  description = "A custom role"
  permissions {
    actions = [
      "Microsoft.Compute/*",
      "Microsoft.Network/*"
    ]
    not_actions = []
  }
  assignable_scopes = ["/subscriptions/${var.subscription_id}"]
}

resource "azurerm_role_assignment" "example_assignment" {
  principal_id   = "29ec2766-fb35-4c65-858f-04237669591d"
  role_definition_name = azurerm_role_definition.example_role.name
  scope          = "/subscriptions/${var.subscription_id}"
}
