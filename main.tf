terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.12.0" # or the latest version you'd like
    }
  }
}

provider "azurerm" {
  features {}

  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
}

module "storage" {
  source              = "./modules/storage"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "datafactory" {
  source              = "./modules/datafactory"
  resource_group_name = var.resource_group_name
  location            = var.location
  adf_name            = var.adf_name
}

module "linked_services" {
  source                   = "./modules/linked_services"
  resource_group_name      = var.resource_group_name
  data_factory_name        = var.adf_name
  storage_account_name     = module.storage.storage_account_name
  databricks_workspace_url = var.databricks_workspace_url

  existing_cluster_id  = var.existing_cluster_id
  data_factory_id      = module.datafactory.data_factory_id
  subscription_id = var.subscription_id
  databricks_access_token = var.databricks_access_token
  blob_connection_string = var.blob_connection_string


}

module "datasets" {
  source              = "./modules/datasets"
  resource_group_name = var.resource_group_name
  data_factory_name   = var.adf_name
  subscription_id     = var.subscription_id
  data_factory_id  = module.datafactory.data_factory_id
  linked_service_name = "BlobStorageLinkedService"

}

module "pipelines" {
  source              = "./modules/pipelines"
  resource_group_name = var.resource_group_name
  data_factory_name   = var.adf_name
  pipeline_json_path  = "adf_assets/quest_pipeline.json"
  subscription_id     = var.subscription_id
  data_factory_id     = module.datafactory.data_factory_id

  depends_on = [module.linked_services]

}

#module "triggers" {
#  source              = "./modules/triggers"
#  resource_group_name = var.resource_group_name
#  data_factory_name   = var.adf_name
#  subscription_id     = var.subscription_id
#
#  storage_account_id  = module.storage.storage_account_id
#  container_name      = module.storage.container_name
#  data_factory_id     = module.datafactory.data_factory_id
#
#}

output "data_factory_name" {
  value = module.datafactory.name
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_container_name" {
  value = module.storage.container_name
}

output "databricks_linked_service_id" {
  value = module.linked_services.databricks_linked_service_id
}