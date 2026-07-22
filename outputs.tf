output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "adf_id" {
  value = azurerm_data_factory.adf.id
}

output "adf_name" {
  value = azurerm_data_factory.adf.name
}

output "adf_identity_principal_id" {
  description = "System-assigned managed identity principal ID, useful for granting RBAC access to storage/key vault"
  value       = azurerm_data_factory.adf.identity[0].principal_id
}
