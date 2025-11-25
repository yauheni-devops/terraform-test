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
  region  = var.region # <--- ВАЖНО: БЕЗ КАВЫЧЕК!
  profile = "trainee"

  default_tags {
    tags = {
      Owner     = "Ivan Ivanov" # <-- Проверьте, что тут ваше имя
      Project   = "Innowise-Lab"
      ManagedBy = "Terraform"
    }
  }
}