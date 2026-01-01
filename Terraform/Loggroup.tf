resource "aws_cloudwatch_log_metric_filter" "AuthorizationFailures" {
  name           = "AuthorizationFailures"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\") }"

  metric_transformation {
    name      = "AuthorizationFailureCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit       = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "CloudTrailChanges" {
  name           = "CloudTrailChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventName = CreateTrail) || ($.eventName = UpdateTrail) || ($.eventName = DeleteTrail) || ($.eventName = StartLogging) || ($.eventName = StopLogging) }"

  metric_transformation {
    name      = "CloudTrailChangesEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit       = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "ConfigActivity" {
  name           = "ConfigActivity"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventSource = config.amazonaws.com) && (($.eventName = StopConfigurationRecorder)||($.eventName = DeleteDeliveryChannel)||($.eventName = PutDeliveryChannel)||($.eventName = PutConfigurationRecorder)) }"

  metric_transformation {
    name      = "AWSConfigChanges"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit       = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "ConsoleSignInFailures" {
  name           = "ConsoleSignInFailures"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ $.eventName = \"ConsoleLogin\" && $.errorMessage = \"*authentication failure*\" && $.userIdentity.type = \"IAMUser\" && $.userIdentity.userName = \"*\"}"
  
  metric_transformation {
    name      = "ConsoleSignInFailureCount"
    namespace = "CloudTrailMetrics"
    value     = "3"
    unit      = "None"
  }
}
resource "aws_cloudwatch_log_metric_filter" "ConsoleSignInWithoutMfa" {
  name           = "ConsoleSignInWithoutMfa"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") && ($.userIdentity.type = \"IAMUser\") && ($.responseElements.ConsoleLogin = \"Success\") }"
  
  metric_transformation {
    name      = "ConsoleSignInWithoutMfaCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "DeletedKMSCMKActivity" {
  name           = "DeletedKMSCMKActivity"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ $.eventSource = kms* && $.errorMessage = \"* is pending deletion.\"}"
  
  metric_transformation {
    name      = "KMSKeyPendingDeletionErrorCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "GatewayChanges" {
  name           = "GatewayChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventName = CreateCustomerGateway) || ($.eventName = DeleteCustomerGateway) || ($.eventName = AttachInternetGateway) || ($.eventName = CreateInternetGateway) || ($.eventName = DeleteInternetGateway) || ($.eventName = DetachInternetGateway) }"
  
  metric_transformation {
    name      = "GatewayEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "IAMPolicyChanges" {
  name           = "IAMPolicyChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName=PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)||($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy)}"
  
  metric_transformation {
    name      = "IAMPolicyChangesEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "NetworkACLEvents" {
  name           = "NetworkACLEvents"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventName = CreateNetworkAcl) || ($.eventName = CreateNetworkAclEntry) || ($.eventName = DeleteNetworkAcl) || ($.eventName = DeleteNetworkAclEntry) || ($.eventName = ReplaceNetworkAclEntry) || ($.eventName = ReplaceNetworkAclAssociation) }"
  
  metric_transformation {
    name      = "NetworkACLEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "RootAccountUsage" {
  name           = "RootAccountUsage"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
  
  metric_transformation {
    name      = "RootAccountUsageCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "S3BucketActivity" {
  name           = "S3BucketActivity"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventSource = s3.amazonaws.com) && (($.eventName = PutBucketAcl) || ($.eventName = PutBucketPolicy) || ($.eventName = PutBucketCors) || ($.eventName = PutBucketLifecycle) || ($.eventName = PutBucketReplication) || ($.eventName = DeleteBucketPolicy) || ($.eventName = DeleteBucketCors) || ($.eventName = DeleteBucketLifecycle) || ($.eventName = DeleteBucketReplication)) }"
  
  metric_transformation {
    name      = "S3BucketActivityEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "SecurityGroupEvents" {
  name           = "SecurityGroupEvents"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventName = AuthorizeSecurityGroupIngress) || ($.eventName = AuthorizeSecurityGroupEgress) || ($.eventName = RevokeSecurityGroupIngress) || ($.eventName = RevokeSecurityGroupEgress) || ($.eventName = CreateSecurityGroup) || ($.eventName = DeleteSecurityGroup) }"
  
  metric_transformation {
    name      = "SecurityGroupEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "VpcChanges" {
  name           = "VpcChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventName = CreateVpc) || ($.eventName = DeleteVpc) || ($.eventName = ModifyVpcAttribute) || ($.eventName = AcceptVpcPeeringConnection) || ($.eventName = CreateVpcPeeringConnection) || ($.eventName = DeleteVpcPeeringConnection) || ($.eventName = RejectVpcPeeringConnection) || ($.eventName = AttachClassicLinkVpc) || ($.eventName = DetachClassicLinkVpc) || ($.eventName = DisableVpcClassicLink) || ($.eventName = EnableVpcClassicLink) }"
  
  metric_transformation {
    name      = "VpcChangesEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}

resource "aws_cloudwatch_log_metric_filter" "VpcRouteTableChanges" {
  name           = "VpcRouteTableChanges"
  log_group_name = aws_cloudwatch_log_group.cloudtrail_logs.name
  pattern        = "{ ($.eventName = CreateRoute) || ($.eventName = CreateRouteTable) || ($.eventName = ReplaceRoute) || ($.eventName = ReplaceRouteTableAssociation) || ($.eventName = DeleteRouteTable) || ($.eventName = DeleteRoute) || ($.eventName = DisassociateRouteTable) }"
  
  metric_transformation {
    name      = "VpcRouteTableChangesEventCount"
    namespace = "CloudTrailMetrics"
    value     = "1"
    unit      = "None"
  }
}