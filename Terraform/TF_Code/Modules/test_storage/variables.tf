variable "storage_account_name" {
  description = "The name of the Storage Account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group."
  type        = string
}

variable "location" {
  description = "The Azure location where the resources will be deployed."
  type        = string
}

variable "container_names" {
  description = "List of container names for the storage account."
  type        = list(string)
}

variable "kv_user_assigned_identity" {
  description = "User-assigned managed identity ID for the Key Vault."
  type        = string
}

variable "managed_identity_id" {
  description = "The Managed Identity ID used for assigning the Storage Blob Data Contributor role."
  type        = string
}

variable "owners_principal_id" {
  description = "The principal ID for the owner role assignment in the storage account."
  type        = string
}

variable "pe_subnet_id" {
  description = "The Subnet ID for the Private Endpoint."
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault to use for Customer Managed Keys (CMK)."
  type        = string
}

variable "key_name" {
  description = "The name of the key in the Key Vault for Customer Managed Keys (CMK)."
  type        = string
}
