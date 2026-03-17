output "api_endpoint" {
  description = "URL publica del API Gateway"
  value       = module.apigateway.api_gateway_url
}

output "ecr_repository" {
  description = "Repositorio ECR para subir imágenes Docker"
  value       = module.compute.ecr_repository_url
}

output "alb_dns" {
  description = "DNS directo del balanceador de carga"
  value       = module.compute.alb_dns_name
}
