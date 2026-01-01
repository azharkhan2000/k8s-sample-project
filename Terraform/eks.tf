data "aws_eks_cluster" "cluster" {
  name = "Test-cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "Test-cluster"
}

data "aws_default_tags" "my_tags" {}

locals {
  cluster_name = "eks-${var.app_name}-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}