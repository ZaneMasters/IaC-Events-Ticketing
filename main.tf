module "networking" {
  source      = "./modules/networking"
  environment = var.environment
}

module "sqs" {
  source      = "./modules/sqs"
  environment = var.environment
}

module "dynamodb" {
  source      = "./modules/dynamodb"
  environment = var.environment
}

module "compute" {
  source             = "./modules/compute"
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  public_subnets     = module.networking.public_subnets
  private_subnets    = module.networking.private_subnets
  sqs_queue_url      = module.sqs.orders_queue_url
  dynamodb_table_arn = module.dynamodb.events_table_arn
  
  # Asumiendo puerto de Spring Boot
  container_port     = 8080
}

module "apigateway" {
  source             = "./modules/apigateway"
  environment        = var.environment
  alb_dns_name       = module.compute.alb_dns_name
  alb_listener_arn   = module.compute.alb_listener_arn
}
