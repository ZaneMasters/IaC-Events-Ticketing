resource "aws_apigatewayv2_api" "http_api" {
  name          = "ticketing-api-${var.environment}"
  protocol_type = "HTTP"
  
  body = templatefile("${path.module}/openapi.yaml.tpl", {
    environment  = var.environment
    alb_dns_name = var.alb_dns_name
  })
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}
