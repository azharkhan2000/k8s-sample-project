locals {
  cluster_names = "${var.eks_name}-cluster"
}

module "trainer_eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "15.0"

  cluster_name    = local.cluster_names
  cluster_version = "1.28"

  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnets                        = module.vpc.private_subnets

  tags = merge(data.aws_default_tags.my_tags.tags, {
    "k8s.io/cluster-autoscaler/${local.cluster_names}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"                = "true"
  })

  node_groups = {
    workers = {
      node_group_name   = "${var.eks_name}-node"
      desired_capacity  = 1
      max_capacity      = 2
      min_capacity      = 1
      instance_type     = "t3a.xlarge"
      k8s_labels        = { Owner = "Terraform" }
      version           = "1.28"
      ami_type          = "AL2_x86_64"
      disk_size         = 100
      additional_tags   = merge(data.aws_default_tags.my_tags.tags, {
        Name          = "eks-${var.eks_name}-canada-workers"
        "managed-by"  = "terraform"
      })
    }
  }

  worker_additional_security_group_ids = []
  workers_additional_policies = [
    aws_iam_policy.eks_autoscaler_policy.arn,
    aws_iam_policy.eks_alb_ingress_controller_policy.arn,
    aws_iam_policy.eks_ecr_access_policy.arn,
    aws_iam_policy.mch_route53_policy.arn,
    aws_iam_policy.eks_describe_volumes.arn
  ]
  map_roles    = var.map_roles
  map_users    = var.map_users
  map_accounts = var.map_accounts
}
