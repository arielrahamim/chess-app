resource "null_resource" "helm-nginx" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "bash helm-upgrade.sh"
    environment = {
      KUBECONFIG   = var.kubeconfig_path
      VALUES_FILE  = local.nginx_values_override
      RELEASE_NAME = "nginx-release"
      NAMESPACE    = "nginx-ingress"
      CHART_URL    = "https://kubernetes.github.io/ingress-nginx"
      CHART_PATH   = "ingress-nginx"
      CHART_NAME   = "ingress-nginx"
    }
  }
}

locals {
  nginx_values_override = <<EOT
controller:
  service:
    annotations: 
      service.beta.kubernetes.io/aws-load-balancer-type: nlb
namespaceOverride: "nginx-ingress"


EOT
}


# resource "null_resource" "helm-alb" {
#   triggers = {
#     always_run = timestamp()
#   }
#   provisioner "local-exec" {
#     command = "bash helm-upgrade.sh"
#     environment = {
#       KUBECONFIG   = var.kubeconfig_path
#       VALUES_FILE  = local.alb_values_override
#       RELEASE_NAME = "my-aws-load-balancer-controller"
#       NAMESPACE    = "kube-system"
#       CHART_URL    = "https://aws.github.io/eks-charts"
#       CHART_PATH   = "aws-load-balancer-controller"
#       CHART_NAME   = "eks"
#     }
#   }
# }

# locals {
#   alb_values_override = <<EOT
# clusterName: ${var.eks_clusterName}

# EOT
# }