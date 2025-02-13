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
  scope       = data.azurerm_subscription.example.id # Use the subscription ID directly

  permissions {
    actions = [
      "Microsoft.Compute/*",
      "Microsoft.Network/*"
    ]
    not_actions = []
  }

  # Assignable scopes: the subscription where the role can be applied
  assignable_scopes = [data.azurerm_subscription.example.id] # Use the subscription ID directly
}

resource "azurerm_role_assignment" "example_assignment" {
  principal_id        = "f736c733-8a38-458b-931a-c6b7b9289e6e"
  role_definition_name = azurerm_role_definition.example_role.name
  # Role assignment scope: the subscription to which the role is assigned
  scope                = data.azurerm_subscription.example.id # Use the subscription ID directly
}