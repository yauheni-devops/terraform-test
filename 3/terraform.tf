terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
  
  # ЗДЕСЬ НЕ ДОЛЖНО БЫТЬ БЛОКА backend "s3"! ОН УЖЕ ЕСТЬ В backend.tf
}

provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Owner     = "Ivan Ivanov" # Ваше имя
      Project   = "Innowise-Trainee"
      ManagedBy = "Terraform"
    }
  }
}