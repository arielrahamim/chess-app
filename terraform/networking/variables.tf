variable "region" {
  type        = list(string)
  description = "region"
}

variable "project_name" {
  type        = string
  description = "project name"
  default     = "hello-world"
}

variable "cidr" {
  type        = string
  description = "cidr for vpc"
}

variable "availability_zones" {
  type        = list(string)
  description = "azs"
}

# variable "private_subnets" {
#   type        = list(string)
#   description = ""
# }

# variable "public_subnets" {
#   type        = list(string)
#   description = "value"
# }

variable "enable_nat_gateway" {
  type        = bool
  description = "create nat_gateway yes/no"
}

variable "single_nat_gateway" {
  type        = bool
  description = "value"
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "create vpn_gateway yes/no"
}
