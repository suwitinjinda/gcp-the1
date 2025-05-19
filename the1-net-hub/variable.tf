# variable "project_id" {
#   description = "GCP Project ID"
#   type        = string
# }

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "project_name" {
  description = "Name of the GCP project"
  type        = string
}

variable "project_id" {
  description = "ID of the GCP project"
  type        = string
}

variable "org_id" {
  description = "Organization ID"
  type        = string
}

variable "billing_account_id" {
  description = "Billing Account ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null
}

# variable "lien" {
#   description = "Prevent accidental deletion"
#   type        = bool
# }

variable "activate_apis" {
  description = "List of APIs to enable"
  type        = list(string)
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "peer_network_stg" {
  description = "peering vpc name"
  type        = string
}

variable "peer_project_id_stg" {
  description = "peering project ID"
  type        = string
}

variable "peer_name_stg" {
  description = "peering name"
  type        = string
}

variable "peer_network_prod" {
  description = "peering vpc name"
  type        = string
}

variable "peer_project_id_prod" {
  description = "peering project ID"
  type        = string
}

variable "peer_name_prod" {
  description = "peering name"
  type        = string
}

variable "lien" {
  description = "Prevent accidental deletion"
  type        = bool
}

variable "labels" {
  description = "Common labels to apply to resources"
  type = map(string)
  default = {
    environment = ""
    team        = ""
    create_by   = ""
  }
}