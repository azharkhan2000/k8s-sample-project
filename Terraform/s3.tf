resource "aws_s3_bucket" "Test-bucket" {
  bucket = "Test-bucket"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "cloudtrail_logs" {
  bucket          = "aws-cloudtrail-logs-multiple-accounts-logs"
  force_destroy   = false
  logging  {
  target_bucket   = "aws-s3-bucket-log"
          }
  server_side_encryption_configuration {
           rule {
               bucket_key_enabled = false 

           apply_server_side_encryption_by_default {
               sse_algorithm = "AES256" 
                }
            }
        }      
}

/*resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.cloudtrail_logs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = ["s3:GetObject"],
        Effect = "Allow",
        Principal = "*",
        Resource = "${aws_s3_bucket.cloudtrail_logs.arn}/*",
      },
    ],
  })
}*/