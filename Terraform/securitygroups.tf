module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4"

  name        = "${var.app_name}-maria-sq" #
  description = "Complete MySQL example security group"
  vpc_id      = module.vpc.vpc_id
  #tags = local.tags

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  #egress
  /*egress_with_cidr_blocks = [
     {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = "0.0.0.0/0"
     },
   ]*/

}

resource "aws_security_group" "ec2_runner_sg" {
  name                  = "action-runner-ec2"
  revoke_rules_on_delete = false
  vpc_id                = module.vpc.vpc_id

  // Ingress rules for IPv4
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "JenkinsPort"
  }

  ingress {
    from_port   = 5806
    to_port     = 5806
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "MYSQL"
  }

  ingress {
    from_port   = 5807
    to_port     = 5807
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "MariaDB"
  }

  // Ingress rules for IPv6
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 5806
    to_port     = 5806
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    description = "MYSQL"
  }

  ingress {
    from_port   = 5807
    to_port     = 5807
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    description = "MariaDB"
  }

  // Egress rule
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

