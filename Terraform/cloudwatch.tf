resource "aws_cloudwatch_metric_alarm" "AWS-SecurityGroup-Events" {
alarm_name          = "AWS-SecurityGroup-Events"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.SecurityGroupEvents.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "VpcRouteTableChangesEventCount" {
  alarm_name          = "VpcRouteTableChangesEventCount"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = aws_cloudwatch_log_metric_filter.VpcRouteTableChanges.metric_transformation[0].name
  namespace           = "CloudTrailMetrics" 
  period              = 300
  statistic           = "Sum"
  threshold           = 5
  datapoints_to_alarm = 1
  alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}


resource "aws_cloudwatch_metric_alarm" "IAMPolicyChangesEvent" {
alarm_name          = "IAMPolicyChangesEvent"
comparison_operator = "GreaterThanThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.IAMPolicyChanges.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "ConsoleSignInWithoutMfa" {
alarm_name          = "ConsoleSignInWithoutMfa"
comparison_operator = "GreaterThanThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.ConsoleSignInWithoutMfa.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "RootAccount-Usuage" {
alarm_name          = "RootAccount-Usuage"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.RootAccountUsage.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "signin-failure" {
alarm_name          = "signin-failure"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 3
metric_name         = aws_cloudwatch_log_metric_filter.ConsoleSignInFailures.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 2
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "AWSConfigChanges" {
alarm_name          = "AWSConfigChanges"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.ConfigActivity.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "S3BucketActivityEvent" {
alarm_name          = "S3BucketActivityEvent"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.S3BucketActivity.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "KMSKeyPendingDeletionError" {
alarm_name          = "KMSKeyPendingDeletionError"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.DeletedKMSCMKActivity.metric_transformation[0].name
namespace           = "CloudTrailLogMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "CloudTrailChangesEvent" {
alarm_name          = "CloudTrailChangesEvent"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.CloudTrailChanges.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 10
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "VpcChangesEventCount" {
alarm_name          = "VpcChangesEventCount"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.VpcChanges.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "GatewayChanges" {
alarm_name          = "GatewayChanges"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.GatewayChanges.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "NetworkACLEvents" {
alarm_name          = "NetworkACLEvents"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods  = 1
metric_name         = aws_cloudwatch_log_metric_filter.NetworkACLEvents.metric_transformation[0].name
namespace           = "CloudTrailMetrics" 
period              = 300
statistic           = "Sum"
threshold           = 5
datapoints_to_alarm = 1
alarm_actions       = [aws_sns_topic.alarm_topic.arn]
}