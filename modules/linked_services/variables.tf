variable "resource_group_name" {
  type = string
}

variable "data_factory_name" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "databricks_workspace_url" {
  type = string
}

variable "storage_account_name" {
  type = string
}
variable "data_factory_id" {
  type = string
}

variable "existing_cluster_id" {
  type = string
}
variable "databricks_access_token" {
  description = "Personal Access Token for Databricks authentication"
  type        = string
  sensitive   = true
}
variable "blob_connection_string" {
  description = "Connection string for the Azure Blob Storage account"
  type        = string
  sensitive   = true
}