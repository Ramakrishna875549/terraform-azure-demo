
resource "azurerm_data_factory_integration_runtime_self_hosted" "shir" {
  name            = var.shir_name
  data_factory_id = azurerm_data_factory.adf.id
  description     = "Self-hosted IR for on-prem / private network data access"
}
