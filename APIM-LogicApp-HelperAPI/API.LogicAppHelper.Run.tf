#=====================
#API: Demo API Operations
#Description
#This defines the operation for the Get Operation
#=====================

#Operation
#This defines the operation for API
#===============================================================================================
resource "azurerm_api_management_api_operation" "utility_logicapps_helper_post_run" {
    resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
    api_management_name = data.azurerm_api_management.eai_apim_instance.name

    api_name            = azurerm_api_management_api.utility_logicapps_helper.name
  
    operation_id        = "utility-api-logic-apps-helper-post-run"
    display_name        = "Run Logic App"
    method              = "POST"
    url_template        = "/{logicAppName}/run"
    description         = "Allows us to run a logic app"
 
    template_parameter {
            name            = "logicAppName"
            required        = true
            type            = "string"
            description     = "The name of the logic app we want to query the callback url for"
    }
    

    response {
        status_code = 200
    }
}

#Operation Policy
#This imports the policy for the operation, this can be either inline xml or an import of a file
#===============================================================================================
resource "azurerm_api_management_api_operation_policy" "utility_logicapps_helper_post_run" {
  resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
  api_management_name = data.azurerm_api_management.eai_apim_instance.name

  api_name            = azurerm_api_management_api.utility_logicapps_helper.name
  operation_id        = azurerm_api_management_api_operation.utility_logicapps_helper_post_run.operation_id

  xml_content = file("API.LogicAppHelper.Run.Policy.txt")
}