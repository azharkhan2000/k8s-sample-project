resource "aws_sqs_queue" "sqs_queue" {
  name                      = "test.fifo"
  fifo_queue                = true
  content_based_deduplication = true
  message_retention_seconds = 1209600

  redrive_policy      = jsonencode(
    {
      deadLetterTargetArn = aws_sqs_queue.sqs_queue_dlq.arn
      maxReceiveCount     = 10
    }
  )
}


resource "aws_sqs_queue" "sqs_queue_dlq" {
  name                        = "test.fifo"
  content_based_deduplication = true
  deduplication_scope         = "queue"
  fifo_queue                  = true
  fifo_throughput_limit       = "perQueue"
  message_retention_seconds   = 1209600
  receive_wait_time_seconds = 10
}

