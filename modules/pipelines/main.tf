terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
    }
  }
}
resource "azapi_resource" "quest_pipeline" {
  type      = "Microsoft.DataFactory/factories/pipelines@2018-06-01"
  name      = "adf_quest_assesment"
  parent_id = var.data_factory_id

  body = file("${path.root}/adf_assets/quest_pipeline.json")
}