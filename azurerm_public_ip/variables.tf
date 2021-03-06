variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)."
}

variable "location" {
  description = "The location where the DNS zone will be created."
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

variable "azurerm_public_ip_name" {
  description = "The suffix name of the public IP address to allocate."
}

variable "azurerm_public_ip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  default = "Static"
}
variable "azurerm_public_ip_sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  default = "Basic"
}

variable "azurerm_resource_group_name" {
  description = "The full name of the resource group where to create the public IP."
}

locals {
  # Define resource names based on the following convention:
  # {azurerm_resource_name_prefix}-{environment}-RESOURCE_TYPE-suffix
  azurerm_public_ip_name = "${var.resource_name_prefix}-${var.environment}-pip-${var.azurerm_public_ip_name}"
}
