// Define outputs for the created GCP project
output "project_id" {
  description = "The ID of the created GCP project"
  value       = module.project-factory.project_id
}

output "project_name" {
  description = "The name of the created GCP project"
  value       = module.project-factory.project_name
}

