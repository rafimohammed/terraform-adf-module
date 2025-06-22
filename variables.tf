variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "adf_name" {
  type = string
}

variable "databricks_workspace_url" {
  type = string
}

variable "existing_cluster_id" {
  type = string
}
variable "blob_connection_string" {
  type = string
}
variable "databricks_access_token" {
  description = "Personal Access Token for Databricks authentication"
  type        = string
  sensitive   = true
}