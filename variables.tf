variable "subscription_id" {}

variable "location" {
  default = "East US"
}

variable "resource_group_name" {
  default = "aks-rg"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "aks-vnet"
}

variable "vnet_address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "adf_name" {
  description = "Name of the Azure Data Factory"
  type        = string
  default     = "adf-project"
}

variable "adf_managed_vnet_enabled" {
  description = "Enable managed virtual network for ADF"
  type        = bool
  default     = false
}

variable "adf_public_network_enabled" {
  description = "Allow public network access to ADF"
  type        = bool
  default     = true
}

variable "adf_github_config" {
  description = "Optional GitHub integration for ADF (leave null to skip)"
  type = object({
    account_name    = string
    branch_name     = string
    git_url         = string
    repository_name = string
    root_folder     = string
  })
  default = null
}
