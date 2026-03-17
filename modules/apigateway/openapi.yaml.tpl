openapi: "3.0.1"
info:
  title: "Ticketing API (${environment})"
  version: "1.0.0"
paths:
  /api/events:
    get:
      responses:
        default:
          description: "Default response"
      x-amazon-apigateway-integration:
        payloadFormatVersion: "1.0"
        type: "http_proxy"
        httpMethod: "ANY"
        uri: "http://${alb_dns_name}/api/events"
        connectionType: "INTERNET"
    post:
      responses:
        default:
          description: "Default response"
      x-amazon-apigateway-integration:
        payloadFormatVersion: "1.0"
        type: "http_proxy"
        httpMethod: "ANY"
        uri: "http://${alb_dns_name}/api/events"
        connectionType: "INTERNET"

  /api/events/{event_id}/availability:
    get:
      parameters:
        - name: "event_id"
          in: "path"
          required: true
          schema:
            type: "string"
      responses:
        default:
          description: "Default response"
      x-amazon-apigateway-integration:
        payloadFormatVersion: "1.0"
        type: "http_proxy"
        httpMethod: "ANY"
        uri: "http://${alb_dns_name}/api/events/{event_id}/availability"
        connectionType: "INTERNET"

  /api/events/{event_id}/purchase:
    post:
      parameters:
        - name: "event_id"
          in: "path"
          required: true
          schema:
            type: "string"
      responses:
        default:
          description: "Default response"
      x-amazon-apigateway-integration:
        payloadFormatVersion: "1.0"
        type: "http_proxy"
        httpMethod: "ANY"
        uri: "http://${alb_dns_name}/api/events/{event_id}/purchase"
        connectionType: "INTERNET"

  /api/orders/{order_id}:
    get:
      parameters:
        - name: "order_id"
          in: "path"
          required: true
          schema:
            type: "string"
      responses:
        default:
          description: "Default response"
      x-amazon-apigateway-integration:
        payloadFormatVersion: "1.0"
        type: "http_proxy"
        httpMethod: "ANY"
        uri: "http://${alb_dns_name}/api/orders/{order_id}"
        connectionType: "INTERNET"
