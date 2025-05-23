// Configure the Google provider with credentials, project ID, and region
provider "google" {
  //credentials = file(var.credentials_file)
#   project     = var.project_id
  region      = var.region
}

// Configure Terraform to use a GCS bucket for storing the state
terraform {
  backend "gcs" {
    bucket = "devops-terraformstate-prod"
    prefix =  "the1-net-shared-prod/project"
  }
}

# terraform {
#   backend "local" {
#     path = "./terraform.tfstate"
#   }
# }