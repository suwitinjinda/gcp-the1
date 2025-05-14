// Provide values for the variables
region                   = "asia-southeast1"
# project_id               = "the1-net-shared-nonprod-abcde"
project_name             = "the1-net-hub"
org_id                   = "84682267661"
billing_account_id       = "01D996-3302C6-5F0E2F"
folder_id                = "237950640851"  // Optional
lien                     = false //use for develope
#api service enable
activate_apis            = ["compute.googleapis.com", "storage.googleapis.com"]

#VPC name
vpc_name                 = "the1-vpc-net-hub"
#VPC peering to stg
peer_network_stg             = "the1-vpc-net-share-stg" //peer VPC network
peer_project_id_stg          = "the1-net-shared-stg-6a78" //peer project ID
peer_name_stg                = "the1-hub-stg-peering" //peer name

#vpc peerign to prod
peer_network_prod             = "the1-vpc-net-share-prod" //peer VPC network
peer_project_id_prod          = "the1-net-shared-prod-3077" //peer project ID
peer_name_prod                = "the1-hub-prod-peering" //peer name

#label
labels = {
  environment = "the1-hub"
  team        = "the1-infra"
  create_by   = "infra1"
}