terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  use_msi = true
  #...
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  dns_servers         = var.dns_servers
  resource_group_name = var.vnet_resource_group_name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_subnet" "subnet" {
  for_each                                  = { for subnet in var.subnets : subnet.name => subnet }
  name                                      = each.key
  resource_group_name                       = azurerm_virtual_network.vnet.resource_group_name
  virtual_network_name                      = azurerm_virtual_network.vnet.name
  address_prefixes                          = each.value.address_prefixes
  #private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled
  service_endpoints   = each.value.service_endpoints
  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", [])
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_delegation[0].name
        actions = delegation.value.service_delegation[0].actions
      }
    }
  }
  #private_link_service_network_policies_enabled  = each.value.private_link_service_network_policies_enabled
}

resource "azurerm_network_security_group" "nsg" {
  # Only create NSG for subnets that have entries in nsg_rules
  for_each = {for s in var.subnets : s.name => s if contains(keys(var.nsg_rules), s.name)}

  name                = "nsg-${each.key}"
  location            = var.location
  resource_group_name = var.vnet_resource_group_name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_network_security_rule" "nsg_rule" {
  for_each = { for idx, rule in var.flat_nsg_rules : "${rule.subnet_name}-${rule.name}" => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.vnet_resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.subnet_name].name
  description                 = each.value.description != null ? each.value.description : "No description provided"
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  # Only associate subnets with NSGs if there are NSG rules defined for those subnets
  for_each = {for s in var.subnets : s.name => s if contains(keys(var.nsg_rules), s.name)}

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

resource "azurerm_route_table" "route_table" {
  location            = var.location
  name                = var.route_table_name
  resource_group_name = var.vnet_resource_group_name

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# resource "azurerm_route" "InternetTraffic" {
#   address_prefix         = "0.0.0.0/0"
#   name                   = "InternetTraffic"
#   next_hop_in_ip_address = "10.1.2.4"
#   next_hop_type          = "VirtualAppliance"
#   resource_group_name    = var.vnet_resource_group_name
#   route_table_name       = azurerm_route_table.route_table.name
#   depends_on = [
#     azurerm_route_table.route_table,
#   ]
# }

resource "azurerm_subnet_route_table_association" "subnet_rt_association" {
  for_each = {for s in var.subnets : s.name => s }

  subnet_id  = azurerm_subnet.subnet[each.key].id
  route_table_id  = azurerm_route_table.route_table.id
  depends_on = [
    azurerm_route_table.route_table,
  ]
}

# resource "azurerm_monitor_diagnostic_setting" "settings" {
#   name                       = "DiagnosticsSettings"
#   target_resource_id         = azurerm_virtual_network.vnet.id
#   log_analytics_workspace_id = var.log_analytics_workspace_id

#   enabled_log {
#     category = "VMProtectionAlerts"
#   }

#   metric {
#     category = "AllMetrics"
#   }
# }

# locals {
#   flat_nsg_rules = flatten([
#     for subnet in var.subnets : [
#       for rule in subnet.nsg_rules : {
#         subnet_name = subnet.name,
#         rule_name   = rule.name,
#         rule        = rule
#       }
#     ]
#   ])
# }

# locals {
#   flat_nsg_rules = flatten([
#     for subnet_name, rules in var.nsg_rules : [
#       for rule in rules : {
#         subnet_name = subnet_name,
#         rule_name   = rule.name,
#         rule        = rule
#       }
#     ]
#   ])
# }

# locals {
#   # Flatten the nsg_rules map to a list of objects with subnet_name included
#   flat_nsg_rules = flatten([
#     for subnet_name, rules in var.nsg_rules : [
#       for rule in rules : merge(rule, { subnet_name = subnet_name })
#     ]
#   ])
# }



# resource "azurerm_network_security_group" "nsg" {
#   for_each            = {for s in var.subnets : s.name => s if length(s.nsg_rules) > 0}
#   name                = "nsg-${each.key}"
#   location            = var.location
#   resource_group_name = var.vnet_resource_group_name
#   tags                = var.tags

#     lifecycle {
#     ignore_changes = [
#         tags
#     ]
#   }
# }


# resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
#   for_each = {for s in var.subnets : s.name => s if length(s.nsg_rules) > 0}

#   subnet_id                 = azurerm_subnet.subnet[each.key].id
#   network_security_group_id = azurerm_network_security_group.nsg[each.key].id
# }
# }
