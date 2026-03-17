terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "terraform-state-tickets"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project     = "TicketingReactor"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}
