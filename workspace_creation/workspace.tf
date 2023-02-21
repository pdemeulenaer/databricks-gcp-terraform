resource "databricks_mws_workspaces" "this" {
  provider       = databricks.accounts
  account_id     = var.databricks_account_id
  workspace_name = var.databricks_workspace_name # "tf-demo-test-${random_string.suffix.result}"
  location       = google_compute_subnetwork.network-with-private-secondary-ip-ranges.region
  cloud_resource_container {
    gcp {
      project_id = var.google_project
    }
  }

  network_id = databricks_mws_networks.this.network_id
  gke_config {
    connectivity_type = "PRIVATE_NODE_PUBLIC_MASTER"
    master_ip_range   = "10.3.0.0/28"
  }

  token {
    comment = "Terraform"
  }

  # this makes sure that the NAT is created for outbound traffic before creating the workspace
  depends_on = [google_compute_router_nat.nat]
}

output "databricks_host" {
  value = databricks_mws_workspaces.this.workspace_url
}

output "databricks_token" {
  value     = databricks_mws_workspaces.this.token[0].token_value
  sensitive = true
}

data "databricks_group" "admins" {
  depends_on   = [ databricks_mws_workspaces.this ]
  provider     = databricks.workspace
  display_name = "admins"
}

resource "databricks_user" "me" {
  depends_on = [ databricks_mws_workspaces.this ]
  provider   = databricks.workspace
  user_name  = data.google_client_openid_userinfo.me.email
}

resource "databricks_group_member" "allow_me_to_login" {
  depends_on = [ databricks_mws_workspaces.this ]
  provider   = databricks.workspace
  group_id   = data.databricks_group.admins.id
  member_id  = databricks_user.me.id
}