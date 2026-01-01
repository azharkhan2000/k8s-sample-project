variable "app_name" {
  default = "test"
}

variable "eks_name" {
  default = "test"
}

variable "Environment" {
  default = "Dev"
}

variable "Application" {
  default = "test"
}

variable "region" {
  default = "us-east-1"
}

variable "aws_access_key" {
  default = ""
}
variable "aws_secret_key" {
  default = ""
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
//    {
//      rolearn  = "arn:aws:iam::66666666666:role/role1"
//      username = "role1"
//      groups   = ["system:masters"]
//    },
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}