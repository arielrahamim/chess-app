# GLOBAL VARS START
################

variable "region" {
  type        = list(string)
  description = "region"
}

variable "project_name" {
  type        = string
  description = "project name"
  default     = "chess-app"
}


# GLOBAL VARS END
#################

# NETWORKING VARS START
######################

variable "availability_zones" {
  type        = list(any)
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
  description = "create nat_gateway"
}

variable "single_nat_gateway" {
  type        = bool
  description = "value"
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "create vpn_gateway"
}

variable "vpc_cluster" {
  type        = number
  description = ""
}

# NETWORKING VARS END
#####################


# EKS VARS START
#################

variable "cluster_addons" {
  description = "Configuration for cluster addons"

  type = map(object({
    most_recent = bool
  }))
}

# variable "subnet_ids" {
#   type        = list(string)
#   description = "A list of subnet IDs where the nodes/node groups will be provisioned."
# }

# variable "control_plane_subnet_ids" {
#   type        = list(string)
#   description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
# }

variable "cluster_version" {
  type        = string
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.27`)"
}

variable "cluster_endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  description = "value"
}
# EKS VARS END

# API GATEWAY START

variable "alb_listener_arn" {
  description = "ARN of the existing ALB Listener"
  type        = string
}

# API GATEWAY END


# nginx-ingress-controller start

# variable "kubeconfig_path" {
#   type = string
# }
# end
