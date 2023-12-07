locals {
  subnets         = cidrsubnets((var.cidr), 4, 4, 4, 4)
  private_subnets = slice(local.subnets, 0, 2)
  public_subnets  = slice(local.subnets, 2, 4)
}

module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = var.project_name
  cidr                 = var.cidr
  azs                  = var.availability_zones
  private_subnets      = local.private_subnets
  public_subnets       = local.public_subnets
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_vpn_gateway   = false

  tags = {
    Terraform = "true"
  }

}