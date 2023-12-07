module "networking" {
  count              = var.vpc_cluster
  source             = "./networking"
  project_name       = "vpc-${count.index + 1}"
  cidr               = "10.0.${tostring(16 * count.index)}.0/20" # 10.0.0.0/20 -> 10.0.16.0/20
  availability_zones = var.availability_zones
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  region             = var.region
}

module "eks" {
  count                           = var.vpc_cluster
  source                          = "./eks"
  vpc_id                          = module.networking[count.index].vpc_id
  project_name                    = "${var.project_name}-${count.index + 1}"
  cluster_addons                  = var.cluster_addons
  subnet_ids                      = module.networking[count.index].private_subnets
  cluster_version                 = var.cluster_version
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
}

module "api-gateway" {
  source             = "./api-gateway"
  alb_listener_arn   = var.alb_listener_arn
  vpc_id             = module.networking[0].vpc_id
  private_subnet_ids = module.networking[0].private_subnets
}


module "nginx-ingress-controller" {
  count           = var.vpc_cluster
  source          = "./nginx-ingress-controller"
  kubeconfig_path = "kubeconfig/${var.project_name}-${count.index + 1}-kubeconfig"
  eks_clusterName = "${var.project_name}-${count.index + 1}"
  depends_on      = [module.eks]
}




# data "aws_alb" "alb" {
#   depends_on = [module.eks]
#   tags = {
#     "${var.project_name}" = "owned"
#   }
# }


# data "aws_lb_listener" "alb_listener" {
#     tags = {
#     "${var.project_name}" = "owned"
#   }
# }


# resource "aws_security_group" "eks_sg" {
#   count = var.vpc_cluster
#   name        = ""
#   description = ""
#   vpc_id      = module.networking[count.index].vpc_id

#   ingress {
#     description      = ""
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = [module.networking[count.index].vpc_cidr]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = ""
#   }
# }