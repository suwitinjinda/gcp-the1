// Provide values for the variables
region                   = "asia-southeast1"
project_id               = "the1-network-stg"
project_name             = "The1 - Network - Staging"
org_id                   = "714395389901"
billing_account_id       = "0148CC-D33E49-7A963E"
folder_id                = "31786212334"  // Common
lien                     = false //use for develope
activate_apis            = ["compute.googleapis.com", "storage.googleapis.com"]

#VPC name
vpc_name                 = "the1-vpc-net-share-stg"
#VPC peering
peer_network             = "the1-vpc-net-hub" //peer VPC hub network
peer_project_id          = "the1-network-hub" //peer hub project ID
peer_name                = "the1-stg-hub-peering" //peer name

#label
labels = {
  environment = "the1-stg"
  team        = "the1-infra"
  create_by   = "infra1"
}

#service project
service_project_ids = []