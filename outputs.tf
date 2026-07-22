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

output "shir_id" {
  value = azurerm_data_factory_integration_runtime_self_hosted.shir.id
}

output "shir_auth_key_primary" {
  description = "Primary auth key used to register the self-hosted IR agent on the on-prem machine"
  value       = azurerm_data_factory_integration_runtime_self_hosted.shir.primary_authorization_key
  sensitive   = true
}

output "shir_auth_key_secondary" {
  description = "Secondary auth key (rotate/regenerate as needed)"
  value       = azurerm_data_factory_integration_runtime_self_hosted.shir.secondary_authorization_key
  sensitive   = true
}
