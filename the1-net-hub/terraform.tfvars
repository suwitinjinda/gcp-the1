// Provide values for the variables
region                   = "asia-southeast1"
project_id               = "the1-network-hub"
project_name             = "The1 - Network - Hub"
org_id                   = "714395389901"
billing_account_id       = "010980-A13142-B2DDB6"
folder_id                = "31786212334"  // Common
lien                     = false //use for develope
#api service enable
activate_apis            = ["compute.googleapis.com", "storage.googleapis.com"]

#VPC name
vpc_name                 = "the1-vpc-net-hub"
#VPC peering to stg
peer_network_stg             = "the1-vpc-net-share-stg" //peer VPC network
peer_project_id_stg          = "the1-network-stg" //peer project ID
peer_name_stg                = "the1-hub-stg-peering" //peer name

#vpc peerign to prod
peer_network_prod             = "the1-vpc-net-share-prod" //peer VPC network
peer_project_id_prod          = "the1-network-prod" //peer project ID
peer_name_prod                = "the1-hub-prod-peering" //peer name

#label
labels = {
  environment = "the1-hub"
  team        = "the1-infra"
  create_by   = "infra1"
}