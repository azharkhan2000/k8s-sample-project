resource "aws_ecr_repository" "Test-api" {
  name                 = "Test-api"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "Test" {
  name                 = "Test"
  image_tag_mutability = "IMMUTABLE"
}

