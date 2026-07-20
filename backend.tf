terraform {
  backend "azurerm" {
    resource_group_name  = "terraformstate-Gg"
    storage_account_name = "tfstate12345678"
    container_name       = "tfstate"
    key                  = "aks.tfstate"
  }
}
