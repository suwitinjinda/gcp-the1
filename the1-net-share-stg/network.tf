# Enable the project as a Shared VPC host project
resource "google_compute_shared_vpc_host_project" "host_project" {
  project = module.project-factory.project_id
}

# Shared VPC with updated subnets
module "shared-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.0"

  project_id   = module.project-factory.project_id
  network_name = var.vpc_name

  subnets = [
    {
      subnet_name           = "the1-subnet-gke-pod-stg"
      subnet_ip             = "10.167.128.0/19"
      subnet_region         = var.region
      subnet_private_access = false
    },
    {
      subnet_name           = "the1-subnet-gke-service-stg"
      subnet_ip             = "10.167.160.0/20"
      subnet_region         = var.region
      subnet_private_access = false
    },
    {
      subnet_name           = "the1-subnet-gke-node-stg"
      subnet_ip             = "10.167.176.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-gke-control-stg"
      subnet_ip             = "10.167.177.0/28"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-frontend-stg"
      subnet_ip             = "10.167.181.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-backend-stg"
      subnet_ip             = "10.167.182.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-db-stg"
      subnet_ip             = "10.167.183.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-compute-stg"
      subnet_ip             = "10.167.184.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-ilb-stg"
      subnet_ip             = "10.167.185.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-proxy-stg"
      subnet_ip             = "10.167.186.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-dataflow-stg"
      subnet_ip             = "10.167.187.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    }
  ]
}

# Cloud Router for Staging
resource "google_compute_router" "the1_router_stg" {
  name    = "the1-router-stg"
  network = module.shared-vpc.network_name
  region  = var.region
  project = module.project-factory.project_id
}

# Cloud NAT for Staging (only for selected subnets)
resource "google_compute_router_nat" "the1_nat_stg" {
  name                               = "the1-nat-stg"
  router                             = google_compute_router.the1_router_stg.name
  region                             = google_compute_router.the1_router_stg.region
  project                            = module.project-factory.project_id
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = "the1-subnet-frontend-stg"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = "the1-subnet-compute-stg"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}




//enable after already created peer project then update var.peer_project_id
data "google_compute_network" "vpc_net_hub" {
  name    = var.peer_network
  project = var.peer_project_id
}

resource "google_compute_network_peering" "stg_hub_peering" {
  name         = var.peer_name
  network      = module.shared-vpc.network_self_link
  peer_network = data.google_compute_network.vpc_net_hub.self_link
}