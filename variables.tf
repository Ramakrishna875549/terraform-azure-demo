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
  description = "Base name of the Azure Data Factory (a unique suffix will be appended)"
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

variable "shir_name" {
  description = "Name of the self-hosted integration runtime"
  type        = string
  default     = "shir-onprem"
}
# variables.tf (additions)
variable "shir_vm_name" {
  description = "Name of the VM hosting the self-hosted integration runtime"
  type        = string
  default     = "vm-shir-01"
}

variable "shir_vm_size" {
  description = "VM size for SHIR VM - DSv2 family"
  type        = string
  default     = "Standard_D2als_V7"  # 2 vCPU, 7GB RAM - meets SHIR minimum spec
}

variable "shir_admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "shiradmin"
}

variable "shir_admin_password" {
  description = "Admin password for the VM - pass via TF_VAR or secret, do not hardcode"
  type        = string
  sensitive   = true
}
variable "subnets" {
  description = "Map of subnet names to their address prefixes"
  type        = map(string)
  default = {
    aks-subnet     = "10.0.1.0/24"
    private-subnet = "10.0.2.0/24"
  }
}
# variables.tf
variable "my_public_ip" {
  description = "Your public IP for RDP access, in CIDR format e.g. 203.0.113.42/32"
  type        = string
}

