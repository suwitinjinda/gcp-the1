// Configure the Project Factory module to create and manage GCP projects
module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.0"

#project detail
  name                = var.project_name
  project_id          = var.project_id
  # project_id          = "${var.project_name}-${random_id.project_id_suffix.hex}"
  random_project_id   = false
  deletion_policy     = "DELETE"  // Allow project deletion use during develope

#org detail
  org_id              = var.org_id
  billing_account     = var.billing_account_id
  folder_id           = var.folder_id  // Optional: Place project in a specific folder

#networking
  auto_create_network   = false

  lien                = var.lien  // Prevent accidental deletion if true
  activate_apis       = var.activate_apis  // List of APIs to enable
  # disable_services_on_destroy = true

  labels = {
    environment = var.labels.environment
    team        = var.labels.team
    project     = var.project_id
    create_by   = var.labels.create_by
  }
}

// Generate a random 4-digit suffix
resource "random_id" "project_id_suffix" {
  byte_length = 2
}