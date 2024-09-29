variable "location" {
  description = "Azure region where resources will be created."
  type        = string
} 

variable "vnet_resource_group_name" {
  description = "Resource group name for the virtual network."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "DNS servers for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets to be created within the VNet."
  type        = map(any)
}

variable "nsg_rules" {
  description = "Map of Network Security Group (NSG) rules."
  type        = map(any)
}

variable "flat_nsg_rules" {
  description = "Flat list of NSG rules."
  type        = list(map(string))
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
}

variable "route_table_name" {
  description = "Name of the route table."
  type        = string
}
