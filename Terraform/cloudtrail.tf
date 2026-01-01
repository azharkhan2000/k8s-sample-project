/*resource "aws_cloudtrail" "Trainner-Account" {
  name                          = "Test-Account"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_logs.bucket
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = "arn:aws:logs:ca-central-1:881425574192:log-group:aws-cloudtrail-logs-Multpile-Accounts:*"
  cloud_watch_logs_role_arn     = "arn:aws:iam::881425574192:role/service-role/CloudTrail-Role-for-Cloudwatch-LogGroup"
  is_organization_trail         = true
  //kms_key_id                    = "arn:aws:kms:ca-central-1:881425574192:key/6d630666-4e8c-43a4-ac74-f998d0f13a1b"

  advanced_event_selector {
    name = "Management events selector"

    field_selector {
      equals          = ["Management"]
      field           = "eventCategory"
    }
  }

  tags = {
    "Accounts" = "Multiple"
    "Name"     = "CloudTrail"
  }

  tags_all = {
    "Accounts" = "Multiple"
    "Name"     = "CloudTrail"
  }
}*/

resource "aws_cloudwatch_log_group" "cloudtrail_logs" {
  name             = "aws-cloudtrail-logs-Multpile-Accounts"
  retention_in_days = 365
}

/*esource "aws_iam_role" "cloudtrail_role" {
  name = "cloudtrail-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}*/

/*resource "aws_iam_policy_attachment" "cloudtrail_s3_policy" {
  name       = "s3-read-only" 
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  roles      = [aws_iam_role.cloudtrail_role.name]
}*/

/*resource "aws_iam_policy_attachment" "cloudtrail_kms_policy" {
  name       = "kms-read-only"
  policy_arn = "arn:aws:iam::aws:policy/service-role/CloudTrail-Role-for-S3"
  roles      = [aws_iam_role.cloudtrail_role.name]
}*/

