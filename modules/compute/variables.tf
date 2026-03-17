variable "environment" {
  description = "Environment string"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "sqs_queue_url" {
  type = string
}

variable "dynamodb_table_arn" {
  type = string
}

variable "container_port" {
  type    = number
  default = 8080
}
