#=====================
#API: Demo API Operations
#Description
#This defines the operation for the Get Operation
#=====================

#Operation
#This defines the operation for API
#===============================================================================================
resource "azurerm_api_management_api_operation" "utility_logicapps_helper_post_run_cached" {
    resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
    api_management_name = data.azurerm_api_management.eai_apim_instance.name

    api_name            = azurerm_api_management_api.utility_logicapps_helper.name
  
    operation_id        = "utility-api-logic-apps-helper-post-run-cached"
    display_name        = "Run Logic App with Cached Response"
    method              = "POST"
    url_template        = "/{logicAppName}/run/cached/{cacheKey}"
    description         = "Allows us to run a logic app"
 
    template_parameter {
            name            = "logicAppName"
            required        = true
            type            = "string"
            description     = "The name of the logic app we want to query the callback url for"
    }

    template_parameter {
            name            = "cacheKey"
            required        = true
            type            = "string"
            description     = "The name of the cache key to use for this logic app response"
    }

    request {
        
        query_parameter {
            name            = "cacheTimeoutSecs"
            required        = false
            type            = "string"
            description     = "The duration in seconds to cache the response for"
            default_value   = 60
        }

        query_parameter {
            name            = "clearCache"
            required        = false
            type            = "boolean"
            description     = "[Optional] Should the cache be cleared to override caching"
            default_value   = false
        }
    }

    response {
        status_code = 200
    }
}

#Operation Policy
#This imports the policy for the operation, this can be either inline xml or an import of a file
#===============================================================================================
resource "azurerm_api_management_api_operation_policy" "utility_logicapps_helper_post_run_cached" {
  resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
  api_management_name = data.azurerm_api_management.eai_apim_instance.name

  api_name            = azurerm_api_management_api.utility_logicapps_helper.name
  operation_id        = azurerm_api_management_api_operation.utility_logicapps_helper_post_run_cached.operation_id

  xml_content = file("API.LogicAppHelper.RunWithCache.Policy.txt")
}
