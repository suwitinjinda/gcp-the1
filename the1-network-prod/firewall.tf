module "network_firewall_policy" {
  source       = "terraform-google-modules/network/google//modules/network-firewall-policy"
  version      = "~> 7.0"
  project_id   = var.project_id
  policy_name  = "the1-prod-vpc-firewall"
  description  = "Production VPC Firewall"
  target_vpcs  = [module.shared-vpc.network_id]

  rules = [
    {
        rule_name      = "identity-aware-proxy"
        description    = "Allow IAP to access internal resources"
        priority       = "1000"
        direction      = "INGRESS"
        action         = "allow"
        enable_logging = false
        match = {
            src_ip_ranges  = ["35.235.240.0/20"]
            dest_ip_ranges = ["0.0.0.0/0"]
            layer4_configs = [
            {
                ip_protocol = "tcp"
                ports       = ["80","3389"]
            },
            ]
        }
    },
    {
        rule_name               = "private-google-access"
        description             = "Allow egress to Google APIs privately"
        priority                = "1001"
        direction               = "EGRESS"
        action                  = "allow"
        disabled                = false
        match = {
            src_ip_ranges  = ["199.36.153.8/30", "34.126.0.0/18"]
            dest_ip_ranges = ["0.0.0.0/0"]
            layer4_configs = [
            {
                ip_protocol = "all"
            },
            ]
        }
    },   
    {
        rule_name               = "internal-vpc-communication"
        description             = "Allow internal traffic between peered VPCs"
        priority                = "1002"
        direction               = "INGRESS"
        action                  = "allow"
        disabled                = true
        match = {
            src_ip_ranges  = ["0.0.0.0/0"]
            dest_ip_ranges = ["0.0.0.0/0"]
            layer4_configs = [
            {
                ip_protocol = "all"
            },
            ]
        }
    },  
    {
        rule_name               = "default-deny-ingress"
        description             = "Block all other ingress traffic"
        priority                = "65534"
        direction               = "INGRESS"
        action                  = "deny"
        disabled                = false
        match = {
            src_ip_ranges  = ["0.0.0.0/0"]
            dest_ip_ranges = ["0.0.0.0/0"]
            layer4_configs = [
            {
                ip_protocol = "all"
            },
            ]
        }
    },      
    {
        rule_name               = "default-deny-egress"
        description             = "Block all other egress traffic"
        priority                = "65535"
        direction               = "EGRESS"
        action                  = "deny"
        disabled                = false
        match = {
            src_ip_ranges  = ["0.0.0.0/0"]
            dest_ip_ranges = ["0.0.0.0/0"]
            layer4_configs = [
            {
                ip_protocol = "all"
            },
            ]
        }
    },         
  ]
}