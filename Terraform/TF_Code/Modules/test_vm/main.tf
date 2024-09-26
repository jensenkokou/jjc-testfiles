# Conditional logic for creating a new resource group or using an existing one
resource "azurerm_resource_group" "vm_rg" {
  count    = var.create_vm_resource_group ? 1 : 0
  name     = var.vm_resource_group_name
  location = var.location
}

data "azurerm_resource_group" "vm_rg" {
  count = var.create_vm_resource_group ? 0 : 1
  name  = var.vm_resource_group_name
}

# Data source to fetch the SSH key from Key Vault
data "azurerm_key_vault_secret" "ssh_key" {
  name         = var.ssh_key_name
  key_vault_id = var.key_vault_id
}

# Network interface with dynamic private IP allocation
resource "azurerm_network_interface" "vm_nic_dynamic" {
  count               = var.private_ip_address == "" ? 1 : 0
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.create_vm_resource_group ? azurerm_resource_group.vm_rg[0].name : data.azurerm_resource_group.vm_rg[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

# Network interface with static private IP allocation
resource "azurerm_network_interface" "vm_nic_static" {
  count               = var.private_ip_address != "" ? 1 : 0
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.create_vm_resource_group ? azurerm_resource_group.vm_rg[0].name : data.azurerm_resource_group.vm_rg[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.create_vm_resource_group ? azurerm_resource_group.vm_rg[0].name : data.azurerm_resource_group.vm_rg[0].name
  network_interface_ids = var.private_ip_address == "" ? [azurerm_network_interface.vm_nic_dynamic[0].id] : [azurerm_network_interface.vm_nic_static[0].id]
  size                  = var.vm_size

  admin_username = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = data.azurerm_key_vault_secret.ssh_key.value
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_encryption_set_id = var.disk_encryption_set_id
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  tags = var.tags
}

output "vm_id" {
  description = "The ID of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm.id
}
