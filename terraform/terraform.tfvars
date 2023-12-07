# GLOBAL VARS START
###################

project_name = "eks-cluster"
region       = ["eu-central-1"]
# GLOBAL VARS END
#################

# GLOBAL NETWORKING START
#########################
vpc_cluster        = 1
availability_zones = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
# private_subnets    = 
# public_subnets     = ["10.0.32.0/20"]
enable_nat_gateway = true
single_nat_gateway = true
enable_vpn_gateway = false
# GLOBAL NETWORKING END
#########################

# EKS START
##########################
cluster_addons = {
  kube-proxy = {
    most_recent = true
  }
  vpc-cni = {
    most_recent = true
  }
  coredns = {
    most_recent = true
  }
}
cluster_version                 = "1.28"
cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true
########################
# EKS END

# ALB START
###################
alb_listener_arn = ""

# ALB END
##################




# nginx-ingress-controller start

# end
