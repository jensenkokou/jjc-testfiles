// Instead of hardcoding values directly into the Terraform files, it's best practice to keep these values in a .tfvars file.
// This keeps our code clean and flexible for different environments (dev, staging, prod).

variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "prefix" {
  type        = string
}

variable "enviroment" {
 type         = string 
}

variable "storage_account_name" {
 type         = string 
}
