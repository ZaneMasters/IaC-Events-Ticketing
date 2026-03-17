resource "aws_sqs_queue" "orders_queue" {
  name                       = "orders-queue"
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 30

  tags = {
    Name        = "OrdersQueue"
    Environment = var.environment
  }
}
