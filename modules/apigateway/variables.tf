variable "environment" {
  description = "Environment identifier"
  type        = string
}

variable "alb_dns_name" {
  type = string
}

variable "alb_listener_arn" {
  type = string
}
