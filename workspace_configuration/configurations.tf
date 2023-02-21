# POOL CREATION
resource "databricks_instance_pool" "dev_pool" {
  provider = databricks.workspace
  instance_pool_name = "Smallest Nodes (${data.databricks_current_user.me.alphanumeric})" #"Smallest Nodes (${var.current_user_alphanumeric})" #
  min_idle_instances = 0
  max_capacity       = 10
  node_type_id       = data.databricks_node_type.smallest.id # var.node_type_id # 
  preloaded_spark_versions = [
    var.spark_version_id # data.databricks_spark_version.latest.id
  ]

  idle_instance_autotermination_minutes = 20
}

# GLOBAL INIT SCRIPTS
# resource "databricks_global_init_script" "dev_init1" {
#   provider = databricks.workspace  
#   source = "${path.module}/../../global_init_scripts/init.sh"
#   name   = "test global init script"
#   enabled = true # by default false
#   position = 0 # position of Global init script (0=first) if multiple
# }

# CLUSTER CREATIONS

# GITHUB INTEGRATION
# https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/git_credential

resource "databricks_git_credential" "dev_github" {
  provider = databricks.workspace
  git_username          = "pdemeulenaer"
  git_provider          = "gitHub"
  personal_access_token = var.github_token
}

# Cloning the template repo
resource "databricks_repo" "dev_repo" {
  provider = databricks.workspace
  url = var.git_repo_template
}

# Cloning the data engineering lectures repo
# resource "databricks_repo" "dev_repo" {
#   provider = databricks.workspace
#   url = var.git_repo_de
# }