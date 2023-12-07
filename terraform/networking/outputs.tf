output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "value"
}

output "private_subnets" {
  value       = module.vpc.private_subnets
  description = ""
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "vpc_name" {
  value = module.vpc.name
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}