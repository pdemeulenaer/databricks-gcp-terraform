terraform {
	backend "remote" {
		organization = "example-org-d50e3c" # org name in Terraform Cloud
		workspaces {
			name = "databricks-gcp-terraform-ws-config" # name of the workspace containing the state file
		}
	}    
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "1.9.2"
    }
  }
}


# Provider defined at Databricks Account level
# provider "databricks" {
#   alias                  = "accounts"
#   host                   = "https://accounts.gcp.databricks.com"
#   google_service_account = var.databricks_google_service_account
#   account_id             = var.databricks_account_id
# }

provider "databricks" {
  alias                  = "workspace"
  host                   = var.databricks_host
  token                  = var.databricks_token
#   google_service_account = var.databricks_google_service_account
}

data "databricks_current_user" "me" {}
data "databricks_spark_version" "latest" {}
data "databricks_node_type" "smallest" {
  local_disk = true
}