terraform {
  cloud {
    organization = "arielrahamim"
    workspaces {
      name = "2VPCs"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}

provider "aws" {
  region = var.region[0] # var.region = list containig only one string (eu-central-1)
}

# provider "kubernetes" {
#   host                   = module.eks[0].cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks[0].cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", "${var.project_name}"]
#   }
# }

# provider "helm" {
#   kubernetes {
#     host                   = module.eks[0].cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks[0].cluster_certificate_authority_data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args        = ["eks", "get-token", "--cluster-name", "${var.project_name}"]
#     }
#   }
# }

# provider "kubernetes" {
#   alias                  = "kubernetes-1"
#   host                   = module.eks[1].cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks[1].cluster_certificate_authority_data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     command     = "aws"
#     args        = ["eks", "get-token", "--cluster-name", "${var.project_name}"]
#   }
# }

# provider "helm" {
#   alias = "helm-1"
#   kubernetes {
#     host                   = module.eks[1].cluster_endpoint
#     cluster_ca_certificate = base64decode(module.eks[1].cluster_certificate_authority_data)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "aws"
#       args        = ["eks", "get-token", "--cluster-name", "${var.project_name}"]
#     }
#   }
# }