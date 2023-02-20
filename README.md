# databricks-gcp-terraform
Creation of Databricks Platform on GCP

## Introduction

This repository is about deploying a Data Science platform made of Databricks Workspaces, using the Terraform provider for Databricks

## Pre-requisites

- You need to have an existing Databricks account for GCP. To create such, look into how to [Start a Databricks free trial on Google Cloud](https://docs.gcp.databricks.com/getting-started/index.html#start-a-databricks-free-trial-on-google-cloud) and related [requirements](https://docs.gcp.databricks.com/getting-started/index.html#requirements). No need to create a workspace manually though, as we will do that by Terraform using this repo

## Main steps to follow

1. Create or get a Google service account

A service account (i.e. non-human "user") needed to create the Workspaces on GCP: it needs to authenticate to be authorised to access data in Google APIs.

You can either create such one (using the console or Terraform) or re-use an existing one. It can make sense to create one, which will be exclusively dedicated to the creation and management of Databricks platform using Terraform.

To create it using Terraform: https://registry.terraform.io/providers/databricks/databricks/latest/docs/guides/gcp-workspace#creating-a-gcp-service-account-for-databricks-provisioning

In this code, we do this in service-account-creation folder

2. Add the Google service account to the Databricks account console

This is a [1-time manual step done in the Databricks Console](https://docs.gcp.databricks.com/dev-tools/terraform/gcp-workspace.html#step-2-add-the-google-service-account-to-the-databricks-on-google-cloud-account)

3. Create a Github repo

Could be a fork of this one or a new one. Add a .gitignore for Terraform with at least

```
*.terraform
*.tfvars
```

4. Setup a remote backend for your state file

5. Run the Terraform magic

- add your Terraform files
- add secrets variables into .tfvars files
- commit, push
- trigger Terraform

## References -- Good links

