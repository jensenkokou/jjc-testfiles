variable "location" {
  description = "azure region where resources will be created."
  type        = string
}

variable "vnet_resource_group_name" {
  description = "resource group name for the virtual network."
  type        = string
}

variable "vnet_name" {
  description = "name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "ddress space for the virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "DNS servers for the virtual network."
  type        = list(string)
}

variable "subnets" {
  description = "map of subnets to be created within the VNet."
  type        = map(any)
}

variable "nsg_rules" {
  description = "map of Network Security Group (NSG) rules."
  type        = map(any)
}

variable "flat_nsg_rules" {
  description = "flat list of NSG rules."
  type        = list(map(string))
}

variable "tags" {
  description = "tags to apply to resources."
  type        = map(string)
}

variable "route_table_name" {
  description = "name of the route table."
  type        = string
}

# Storage module variables
variable "storage_resource_group_name" {
  description = "resource group name for the storage account."
  type        = string
}

variable "container_names" {
  description = "list of container names for the storage account."
  type        = list(string)
}

variable "storage_subnet_id" {
  description = "id of the subnet where the storage account is located."
  type        = string
}

variable "managed_identity_id" {
  description = "id of the managed identity used by the storage account."
  type        = string
}

variable "storage_account_name" {
  description = "name of the storage account."
  type        = string
}

variable "pe_subnet_id" {
  description = "private endpoint subnet ID."
  type        = string
}

variable "user_assigned_identity_id" {
  description = "iDdof the user-assigned identity for storage access."
  type        = string
}

variable "owners_principal_id" {
  description = "principal ID for storage account owners."
  type        = string
}

variable "kv_user_assigned_identity" {
  description = "user-assigned identity for accessing the Key Vault."
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault for the storage account."
  type        = string
}

variable "key_name" {
  description = "Key name for storage account encryption."
  type        = string
}

# VM module variables
variable "create_vm_resource_group" {
  description = "Boolean to determine if a resource group should be created for the VM."
  type        = bool
  default     = false
}

variable "vm_resource_group_name" {
  description = "Resource group name for the VM."
  type        = string
}

variable "vm_subnet_id" {
  description = "ID of the subnet where the VM is located."
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine."
  type        = string
}

variable "private_ip_address" {
  description = "Private IP address of the virtual machine."
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the virtual machine image."
  type        = string
}

variable "image_offer" {
  description = "Offer of the virtual machine image."
  type        = string
}

variable "image_sku" {
  description = "SKU of the virtual machine image."
  type        = string
}

variable "image_version" {
  description = "Version of the virtual machine image."
  type        = string
  default     = "latest"
}

variable "disk_encryption_set_id" {
  description = "Disk encryption set ID."
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key used for VM access."
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault for VM access."
  type        = string
}







