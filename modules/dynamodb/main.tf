# Events Table
resource "aws_dynamodb_table" "events" {
  name           = "Events"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "EventsTable"
    Environment = var.environment
  }
}

# Tickets Table
resource "aws_dynamodb_table" "tickets" {
  name           = "Tickets"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  range_key      = "eventId"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "eventId"
    type = "S"
  }

  global_secondary_index {
    name               = "EventIdIndex"
    hash_key           = "eventId"
    projection_type    = "ALL"
  }

  tags = {
    Name        = "TicketsTable"
    Environment = var.environment
  }
}

# Orders Table
resource "aws_dynamodb_table" "orders" {
  name           = "Orders"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "OrdersTable"
    Environment = var.environment
  }
}
