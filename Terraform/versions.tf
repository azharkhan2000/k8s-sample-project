terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
  required_version = ">= 0.13"
}
