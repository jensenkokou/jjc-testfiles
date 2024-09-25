// Resource Group Information Outputs

output "resource_group_name" {
  description = "The name of the Azure Resource Group"
  value       = azurerm_resource_group.mdastartup.name
}

output "resource_group_location" {
  description = "The location of the Resource Group"
  value       = azurerm_resource_group.mdastartup.location
}

output "resource_group_id" {
  description = "The ID of the Resource Group"
  value       = azurerm_resource_group.mdastartup.id
}

// Virtual Network Information Outputs 

output "virtual_network_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.main.name
}

output "virtual_network_address_space" {
  description = "The address space of the Virtual Network"
  value       = azurerm_virtual_network.main.address_space
}

output "virtual_network_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.main.id
}

// We can add more to this if needed this is just a start
