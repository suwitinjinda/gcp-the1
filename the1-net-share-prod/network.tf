
# Enable the project as a Shared VPC host project
resource "google_compute_shared_vpc_host_project" "host_project" {
  project = module.project-factory.project_id
}

# Shared VPC with updated subnets for production
module "shared-vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.0"

  project_id   = module.project-factory.project_id
  network_name = var.vpc_name

  subnets = [
    {
      subnet_name           = "the1-subnet-gke-pod-prod"
      subnet_ip             = "10.167.0.0/19"
      subnet_region         = var.region
      subnet_private_access = false
    },
    {
      subnet_name           = "the1-subnet-gke-service-prod"
      subnet_ip             = "10.167.32.0/20"
      subnet_region         = var.region
      subnet_private_access = false
    },
    {
      subnet_name           = "the1-subnet-gke-node-prod"
      subnet_ip             = "10.167.48.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-gke-control-prod"
      subnet_ip             = "10.167.49.0/28"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-frontend-prod"
      subnet_ip             = "10.167.53.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-backend-prod"
      subnet_ip             = "10.167.54.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-db-prod"
      subnet_ip             = "10.167.55.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-compute-prod"
      subnet_ip             = "10.167.56.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-ilb-prod"
      subnet_ip             = "10.167.57.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-proxy-prod"
      subnet_ip             = "10.167.58.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "the1-subnet-dataflow-prod"
      subnet_ip             = "10.167.59.0/24"
      subnet_region         = var.region
      subnet_private_access = true
    }
  ]
}

# Cloud Router for Production
resource "google_compute_router" "the1_router_prod" {
  name    = "the1-router-prod"
  network = module.shared-vpc.network_name
  region  = var.region
  project = module.project-factory.project_id
}

# Cloud NAT for Production (only for selected subnets)
resource "google_compute_router_nat" "the1_nat_prod" {
  name                               = "the1-nat-prod"
  router                             = google_compute_router.the1_router_prod.name
  region                             = google_compute_router.the1_router_prod.region
  project                            = module.project-factory.project_id
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = "the1-subnet-frontend-prod"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = "the1-subnet-compute-prod"
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


//enable after already created peer project then update var.peer_project_id
data "google_compute_network" "vpc_net_hub" {
  name    = var.peer_network
  project = var.peer_project_id
}

resource "google_compute_network_peering" "prod_hub_peering" {
  name         = var.peer_name
  network      = module.shared-vpc.network_self_link
  peer_network = data.google_compute_network.vpc_net_hub.self_link
}