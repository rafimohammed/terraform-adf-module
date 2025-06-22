terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
  }
}

resource "azurerm_data_factory_linked_service_azure_databricks" "databricks" {
  name                = "DatabricksLinkedService"
  data_factory_id     = var.data_factory_id
  adb_domain          = var.databricks_workspace_url
  existing_cluster_id = var.existing_cluster_id
  access_token        = var.databricks_access_token
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "blob" {
  name            = "BlobStorageLinkedService"
  data_factory_id = var.data_factory_id
  connection_string = var.blob_connection_string
}

resource "azapi_resource" "rest_linked_service" {
  type      = "Microsoft.DataFactory/factories/linkedservices@2018-06-01"
  name      = "restresource1"
  parent_id = var.data_factory_id

  body = jsonencode({
    properties = {
      type = "RestService"
      typeProperties = {
        url                 = "https://download.bls.gov/pub/time.series/pr/"
        authenticationType  = "Anonymous"
      }
    }
  })
}