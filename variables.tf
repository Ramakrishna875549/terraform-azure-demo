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
