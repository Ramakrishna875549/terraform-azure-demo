resource "azurerm_public_ip" "shir_pip" {
  name                = "${var.shir_vm_name}-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
 }

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value]
}

# shir-vm.tf
resource "azurerm_network_interface" "shir_nic" {
  name                = "${var.shir_vm_name}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet["aks-subnet"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.shir_pip.id
  }


}

resource "azurerm_windows_virtual_machine" "shir_vm" {
  name                = var.shir_vm_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = var.shir_vm_size
  admin_username      = var.shir_admin_username
  admin_password      = var.shir_admin_password

  network_interface_ids = [
    azurerm_network_interface.shir_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 128
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  # Recommended: disable public IP; access via Bastion or private network only
  # If you need direct RDP, attach a azurerm_public_ip and reference it in
  # the network interface ip_configuration block instead.

 
}

# NSG allowing outbound HTTPS (443) to Azure - SHIR only needs outbound
resource "azurerm_network_security_group" "shir_nsg" {
  name                = "${var.shir_vm_name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowRDPFromMyIP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "49.207.55.235"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowOutboundHTTPS"
    priority                   = 200
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyInboundDefault"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "shir_nic_nsg" {
  network_interface_id     = azurerm_network_interface.shir_nic.id
  network_security_group_id = azurerm_network_security_group.shir_nsg.id
}
