terraform {
	backend "remote" {
		organization = "example-org-d50e3c" # org name in Terraform Cloud
		workspaces {
			name = "databricks-gcp-terraform-ws" # name of the workspace containing the state file
		}
	}    
  required_providers {
    databricks = {
      source = "databricks/databricks"
      version = "1.9.2"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.53.1"
    }
  }
}

provider "google" {
  project = var.google_project
  region  = var.google_region
  zone    = var.google_zone
}

# Provider defined at Databricks Account level
provider "databricks" {
  alias                  = "accounts"
  host                   = "https://accounts.gcp.databricks.com"
  google_service_account = var.databricks_google_service_account
  account_id             = var.databricks_account_id
}

data "google_client_openid_userinfo" "me" {
}

data "google_client_config" "current" {
}

resource "random_string" "suffix" {
  special = false
  upper   = false
  length  = 6
}