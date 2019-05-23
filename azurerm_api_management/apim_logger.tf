
## Connect the API management resource with the EventHub logger

resource "null_resource" "azurerm_apim_logger" {
  count = "${var.environment == "production" ? 1 : 0}"

  triggers = {
    azurerm_function_app_id            = "${azurerm_function_app.azurerm_function_app.id}"
    azurerm_resource_group_name        = "${var.resource_group_name}"
    azurerm_apim_eventhub_id           = "${azurerm_eventhub.azurerm_apim_eventhub.id}"
    azurerm_eventhub_connection_string = "${azurerm_eventhub_authorization_rule.azurerm_apim_eventhub_rule.primary_connection_string}"
    azurerm_apim_id                    = "${module.azurerm_api_management.id}"
    provisioner_version                = "1"
  }

  depends_on = ["module.azurerm_api_management"]

  provisioner "local-exec" {
    command = "${join(" ", list(
      "ts-node ${var.apim_logger_provisioner}",
      "--environment ${var.environment}",
      "--azurerm_resource_group ${var.resource_group_name}",
      "--azurerm_apim ${local.azurerm_apim_name}",
      "--azurerm_apim_eventhub ${azurerm_eventhub.azurerm_apim_eventhub.name}",
      "--apim_configuration_path ${var.apim_configuration_path}",
      "--azurerm_apim_eventhub_connstr ${azurerm_eventhub_authorization_rule.azurerm_apim_eventhub_rule.primary_connection_string}"))
    }"

    environment = {
      ENVIRONMENT = "${var.environment}"
      TF_VAR_ADB2C_TENANT_ID = "${var.ADB2C_TENANT_ID}"
      TF_VAR_DEV_PORTAL_CLIENT_ID = "${data.azurerm_key_vault_secret.dev_portal_client_id.value}"
      TF_VAR_DEV_PORTAL_CLIENT_SECRET = "${data.azurerm_key_vault_secret.dev_portal_client_secret.value}"
    }
  }
}