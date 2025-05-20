// Define outputs for the created GCP project
output "project_id" {
  description = "The ID of the created GCP project"
  value       = module.project-factory.project_id
}

output "project_name" {
  description = "The name of the created GCP project"
  value       = module.project-factory.project_name
}

// Define outputs for the Shared VPC network
output "shared_vpc_network_name" {
  description = "The name of the Shared VPC network"
  value       = module.shared-vpc.network_name
}

// Define output to show if the project is a Shared VPC host project
output "is_host_project" {
  description = "Indicates if the project is a Shared VPC host project"
  value       = google_compute_shared_vpc_host_project.host_project.project != null ? true : false
}

