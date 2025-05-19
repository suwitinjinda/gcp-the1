resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = module.project-factory.project_id
}

resource "google_compute_subnetwork" "hub_compute_stg" {
  name          = "the1-subnet-hub-compute-stg"
  ip_cidr_range = "10.167.180.0/24"
  project       = module.project-factory.project_id
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "hub_compute_prod" {
  name          = "the1-subnet-hub-compute-prod"
  ip_cidr_range = "10.167.52.0/24"
  project       = module.project-factory.project_id
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
  private_ip_google_access = true
}


//enable after already created peer project then update var.peer_project_id

//peering to stg
data "google_compute_network" "vpc_net_share_stg" {
  name    = var.peer_network_stg
  project = var.peer_project_id_stg
}

resource "google_compute_network_peering" "hub_stg_peering" {
  name         = var.peer_name_stg
  network      = google_compute_network.vpc_network.self_link
  peer_network = data.google_compute_network.vpc_net_share_stg.self_link
}

//peefing to prod
data "google_compute_network" "vpc_net_share_prod" {
  name    = var.peer_network_prod
  project = var.peer_project_id_prod
}

resource "google_compute_network_peering" "hub_prod_peering" {
  name         = var.peer_name_prod
  network      = google_compute_network.vpc_network.self_link
  peer_network = data.google_compute_network.vpc_net_share_prod.self_link
}