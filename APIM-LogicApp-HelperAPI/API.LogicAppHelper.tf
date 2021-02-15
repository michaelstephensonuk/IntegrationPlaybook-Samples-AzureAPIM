


#API
#This defines the api
#===================================================
resource "azurerm_api_management_api" "utility_logicapps_helper" {
  resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
  api_management_name = data.azurerm_api_management.eai_apim_instance.name
  
  name                = "utility-api-logic-apps-helper"
  revision            = "1"
  display_name        = "Utility API - Logic Apps Helper"
  path                = "eai/platform/logicapps"
  protocols           = ["https"]    
  service_url         = "https://management.azure.com"
  description         = "This is the api which provides helper methods for interacting with logic apps"
}

#API Policy
#This will let you add a policy to the api level object
#======================================================
resource "azurerm_api_management_api_policy" "utility_logicapps_helper" {
  resource_group_name = data.azurerm_api_management.eai_apim_instance.resource_group_name
  api_management_name = data.azurerm_api_management.eai_apim_instance.name

  api_name            = azurerm_api_management_api.utility_logicapps_helper.name
  
  xml_content = <<XML
<policies>
    <inbound>
        <base />        
    </inbound>   
</policies>
XML
}