resource "aws_iam_policy" "eks_alb_ingress_controller_policy" {
  name        = "${var.app_name}_eks_alb_ingress_controller_policy"
  path        = "/"
  description = "EKS ALB ingress controller policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "acm:DescribeCertificate",
        "acm:ListCertificates",
        "acm:GetCertificate"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateSecurityGroup",
        "ec2:CreateTags",
        "ec2:DeleteTags",
        "ec2:DeleteSecurityGroup",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAddresses",
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVpcs",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifyNetworkInterfaceAttribute",
        "ec2:RevokeSecurityGroupIngress"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticloadbalancing:AddListenerCertificates",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:CreateRule",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:DeleteRule",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:DescribeListenerCertificates",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:DescribeSSLPolicies",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:ModifyRule",
        "elasticloadbalancing:ModifyTargetGroup",
        "elasticloadbalancing:ModifyTargetGroupAttributes",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:RemoveListenerCertificates",
        "elasticloadbalancing:RemoveTags",
        "elasticloadbalancing:SetIpAddressType",
        "elasticloadbalancing:SetSecurityGroups",
        "elasticloadbalancing:SetSubnets",
        "elasticloadbalancing:SetWebACL"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:CreateServiceLinkedRole",
        "iam:GetServerCertificate",
        "iam:ListServerCertificates"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "cognito-idp:DescribeUserPoolClient"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "waf-regional:GetWebACLForResource",
        "waf-regional:GetWebACL",
        "waf-regional:AssociateWebACL",
        "waf-regional:DisassociateWebACL"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "tag:GetResources",
        "tag:TagResources"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "waf:GetWebACL"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "wafv2:GetWebACL",
        "wafv2:GetWebACLForResource",
        "wafv2:AssociateWebACL",
        "wafv2:DisassociateWebACL"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "shield:DescribeProtection",
        "shield:GetSubscriptionState",
        "shield:DeleteProtection",
        "shield:CreateProtection",
        "shield:DescribeSubscription",
        "shield:ListProtections"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "eks_autoscaler_policy" {
  name        = "${var.app_name}_eks_autoscaler_policy"
  path        = "/"
  description = "EKS Autoscaler policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeLaunchTemplateVersions"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}


data "aws_iam_policy_document" "mch_route53_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = ["arn:aws:route53:::hostedzone/*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "mch_route53_policy" {
  name = "${var.app_name}_AllowRoute53Access"
  path = "/"
  description = "Allow access Route53 (whalebone.com)"
  policy = data.aws_iam_policy_document.mch_route53_policy_document.json
}

resource "aws_iam_policy_attachment" "eks_route53_attachment" {
  name       = "AllowEKSAccessToRoute53"
  roles      = [module.trainer_eks.worker_iam_role_name, module.trainer_eks.cluster_iam_role_name]
  policy_arn = aws_iam_policy.mch_route53_policy.arn
}

resource "aws_iam_policy_attachment" "eks_cloudwatch_attachment" {
  name = "AllowEKSAccessToCloudWatch"
  roles      = [module.trainer_eks.worker_iam_role_name, module.trainer_eks.cluster_iam_role_name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_policy" "eks_ecr_access_policy" {
  name        = "${var.app_name}_eks_ecr_access_policy"
  path        = "/"
  description = "EKS access to ECR policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:BatchGetImage",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetAuthorizationToken"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "eks_describe_volumes" {
  name        = "${var.app_name}_eks_describe_volumes"
  path        = "/"
  description = "EKS access to EBS volumes"

  policy =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ec2:DescribeVolumes"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "ec2_actions" {
  name        = "EC2Policy"
  description = "Allows managing EC2 instances for GITHUB Action-Runner"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["ec2:RunInstances", "ec2:TerminateInstances", "ec2:DescribeInstances", "ec2:DescribeInstanceStatus"],
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_policy" "ec2_create_tags_policy" {
  name        = "EC2CreateTagsPolicy"
  description = "Allows creating tags when launching EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["ec2:CreateTags"],
        Resource = "*",
        Condition = {
          StringEquals = {
            "ec2:CreateAction" = "RunInstances"
          }
        }
      }
    ],
  })
}

resource "aws_iam_policy" "dead_letter_policy" {
  name        = "dead_letter_policy"
  description = "Policy for dead letter queue"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "sqs1",
        Effect    = "Allow",
        Action    = "SQS:*",
        Resource  = aws_sqs_queue.sqs_queue.arn
      }
    ]
  })
}