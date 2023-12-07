variable "alb_listener_arn" {
  description = "ARN of the existing ALB Listener"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}