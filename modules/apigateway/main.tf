resource "aws_apigatewayv2_api" "http_api" {
  name          = "ticketing-api-${var.environment}"
  protocol_type = "HTTP"
}

# Link API Gateway directly to ALB via VPC Link (required for private ALBs, but works for public too)
resource "aws_apigatewayv2_integration" "alb_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "HTTP_PROXY"
  integration_uri  = "http://${var.alb_dns_name}" # URI requires a valid HTTP endpoint for HTTP_PROXY
  
  # For HTTP APIs hitting public ALBs, method ANY and proxy works.
  # If ALB was fully private, a VPC Link would be needed here. 
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.alb_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default"
  auto_deploy = true
}
