variable "create_vm_resource_group" {
  description = "Boolean to determine if a resource group should be created for the VM."
  type        = bool
  default     = true
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

variable "location" {
    description = "Location of the Azure region"
    type = string
  
}

variable "key_vault_id" {
  description = "Key Vault Id"
  type = string
}

variable "managed_identity_id" {
  description = "id"
  type = string
}

variable "tags" {
    description = ".."
     type = string
}

variable "subnet_id" {
    description = "subnet id"
    type = string
  
}