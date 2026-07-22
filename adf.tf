# adf.tf
resource "random_string" "adf_suffix" {
  length  = 6
  special = false
  upper   = false
}
resource "azurerm_data_factory" "adf" {
  name                            = "${var.adf_name}-${random_string.adf_suffix.result}"
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  managed_virtual_network_enabled = var.adf_managed_vnet_enabled
  public_network_enabled          = var.adf_public_network_enabled

  identity {
    type = "SystemAssigned"
  }

  dynamic "github_configuration" {
    for_each = var.adf_github_config != null ? [var.adf_github_config] : []
    content {
      account_name    = github_configuration.value.account_name
      branch_name     = github_configuration.value.branch_name
      git_url         = github_configuration.value.git_url
      repository_name = github_configuration.value.repository_name
      root_folder     = github_configuration.value.root_folder
    }
  }

 
}

