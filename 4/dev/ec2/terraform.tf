terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Owner     = "Yauheni Filiuta"
      Project   = "Innowise-Trainee"
      ManagedBy = "Terraform"
      Env       = "dev"
    }
  }
}