

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.43.0"
    }
  }
}

provider "azurerm" {
    skip_provider_registration = true
    features {
        key_vault {
	        recover_soft_deleted_key_vaults = true
            purge_soft_delete_on_destroy = true
        }
    }
}

data "azurerm_client_config" "current" {}


#Resource Group
#Description: This will allow us to reference the main EAI resource group
#========================================================================
data "azurerm_resource_group" "eai_resource_group" {
  name     = var.eai_resource_group
}

#Key Vault

#This is the resource group used to host our key vault for devops
data "azurerm_resource_group" "eai_keyvault_resource_group" {
  name     = var.eai_keyvault_resourcegroup_name
}

#Description: We will use the data object to reference the key vault store to upload things in the build if required
#===================================================================================================================
data "azurerm_key_vault" "eai_keyvault" {
  name                = var.eai_keyvault_name
  resource_group_name = data.azurerm_resource_group.eai_keyvault_resource_group.name
}

#|APIM Instance
#Description: This is a reference to the API Management instance for this environment
#===================================================================================================================
data "azurerm_api_management" "eai_apim_instance" {
  name                = var.eai_apim_name
  resource_group_name = data.azurerm_resource_group.eai_resource_group.name
}
