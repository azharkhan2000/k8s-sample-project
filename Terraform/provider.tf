provider "aws" {
  region = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  default_tags {
    tags = {
      "Application" = "Test"
      "Environment" = "Dev"
      "Provisoner" = "Terraform"
      "CostName"    = "${var.Application}_${var.Environment}"
    }
  }
}

provider "random" {
}

provider "local" {
}

provider "tls" {
}

provider "null" {
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
 # load_config_file       = false
}
