# Generic variables

variable "environment" {
  description = "The nick name identifying the type of environment (i.e. test, staging, production)"
}

variable "resource_name_prefix" {
  description = "The prefix used to name all resources created."
}

# Specific variables for application insights
variable "applications_insights" {
  type        = "list"
  default     = []
  description = "A list of map(s) that contains one or application insights definition. Please read README.md to the list of keys required to be present"
}

variable "azurerm_application_insights_instrumentation_key" {
  description = "The secret name used for app insights instrumentation key."
  default     = "fn2-commons-app-insights-instrumentation-key"
}


locals {
  # Define resource names based on the following convention:  # {azurerm_resource_name_prefix}-{environment}-RESOURCE_TYPE-SUFFIX
  azurerm_resource_group_name = "${var.resource_name_prefix}-${var.environment}-rg"
  azurerm_key_vault_name      = "${var.resource_name_prefix}-${var.environment}-keyvault"
}
