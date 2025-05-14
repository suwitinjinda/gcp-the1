// Provide values for the variables
region                   = "asia-southeast1"
# project_id               = "the1-net-shared-nonprod-abcde"
project_name             = "the1-net-stg"
org_id                   = "84682267661"
billing_account_id       = "01D996-3302C6-5F0E2F"
folder_id                = "237950640851"  // Optional
lien                     = false //use for develope
activate_apis            = ["compute.googleapis.com", "storage.googleapis.com"]

#VPC name
vpc_name                 = "the1-vpc-net-share-stg"
#VPC peering
peer_network             = "the1-vpc-net-hub" //peer VPC hub network
peer_project_id          = "the1-net-hub-9cc0" //peer hub project ID
peer_name                = "the1-stg-hub-peering" //peer name

#label
labels = {
  environment = "the1-stg"
  team        = "the1-infra"
  create_by   = "infra1"
}
