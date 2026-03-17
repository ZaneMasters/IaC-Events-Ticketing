output "events_table_arn" {
  value = aws_dynamodb_table.events.arn
}

output "tickets_table_arn" {
  value = aws_dynamodb_table.tickets.arn
}

output "orders_table_arn" {
  value = aws_dynamodb_table.orders.arn
}
