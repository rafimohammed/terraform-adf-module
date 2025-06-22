terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
  }
}

resource "azurerm_data_factory_dataset_delimited_text" "input_dataset" {
  name = "Json_blob_LS"
  data_factory_id     = var.data_factory_id
  linked_service_name = "BlobStorageLinkedService"
  folder              = "Datasets"

  azure_blob_storage_location {
    container = "pipeline-input"
    filename = "input.csv"
  }

  column_delimiter = ","
  encoding         = "UTF-8"
}