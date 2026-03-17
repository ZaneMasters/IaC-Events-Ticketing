output "orders_queue_url" {
  value       = aws_sqs_queue.orders_queue.url
  description = "The URL of the SQS Queue"
}

output "orders_queue_arn" {
  value       = aws_sqs_queue.orders_queue.arn
  description = "The ARN of the SQS Queue"
}
