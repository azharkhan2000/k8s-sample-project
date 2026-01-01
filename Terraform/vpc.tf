module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "tf-${var.app_name}"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}d"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnet_tags = {
    "KubernetesCluster" = local.cluster_names
    "kubernetes.io/role/elb" = ""
  }

  enable_dns_hostnames = true
  enable_dns_support = true
  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = false
}