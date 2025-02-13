provider "azurerm" {
  features {}
}

# Fetch the current subscription data
data "azurerm_subscription" "example" {
  # This automatically pulls the subscription ID from the authenticated Azure account
}

resource "azurerm_role_definition" "example_role" {
  name        = "example_role"
  description = "A custom role"
  scope       = "/subscriptions/${data.azurerm_subscription.example.id}"

  permissions {
    actions = [
      "Microsoft.Compute/*",
      "Microsoft.Network/*"
    ]
    not_actions = []
  }

  # Assignable scopes: the subscription where the role can be applied
  assignable_scopes = ["/subscriptions/${data.azurerm_subscription.example.id}"]
}

resource "azurerm_role_assignment" "example_assignment" {
  principal_id        = "29ec2766-fb35-4c65-858f-04237669591d"
  role_definition_name = azurerm_role_definition.example_role.name
  # Role assignment scope: the subscription to which the role is assigned
  scope                = "/subscriptions/${data.azurerm_subscription.example.id}"
}