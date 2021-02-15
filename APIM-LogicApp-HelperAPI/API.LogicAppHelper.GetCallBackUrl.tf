#=====================
#API: Demo API Operations
#Description
#This defines the operation for the Get Operation
#=====================

#Operation
#This defines the operation for API
#===============================================================================================
resource "azurerm_api_management_api_operation" "utility_logicapps_helper_get_callbackurl" {
    resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
    api_management_name = data.azurerm_api_management.eai_apim_instance.name

    api_name            = azurerm_api_management_api.utility_logicapps_helper.name
  
    operation_id        = "utility-api-logic-apps-helper-get-callbackurl"
    display_name        = "Call Back Url"
    method              = "GET"
    url_template        = "/callbackurl/{logicAppName}"
    description         = "Allows us to retrieve the call back url for a logic app"
 
    template_parameter {
            name            = "logicAppName"
            required        = true
            type            = "string"
            description     = "The name of the logic app we want to query the callback url for"
    }

    request {
        
        query_parameter {
            name            = "cacheTimeoutSecs"
            required        = true
            type            = "string"
            description     = "The duration in seconds to cache the response for"
            default_value   = 0
        }
    }

    response {
        status_code = 200
    }
}

#Operation Policy
#This imports the policy for the operation, this can be either inline xml or an import of a file
#===============================================================================================
resource "azurerm_api_management_api_operation_policy" "utility_logicapps_helper_get_callbackurl" {
  resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
  api_management_name = data.azurerm_api_management.eai_apim_instance.name

  api_name            = azurerm_api_management_api.utility_logicapps_helper.name
  operation_id        = azurerm_api_management_api_operation.utility_logicapps_helper_get_callbackurl.operation_id

  xml_content = file("API.LogicAppHelper.GetCallBackUrl.Policy.txt")
}