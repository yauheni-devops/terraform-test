terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
  
  # Backend локальный по умолчанию, поэтому блок backend не пишем (или можно явно указать local)
}

provider "aws" {
  region = "eu-north-1" # Укажите ваш регион

  default_tags {
    tags = {
      Owner     = "Yauheni Filiuta"     
      Project   = "Innowise-Trainee"
      ManagedBy = "Terraform"
    }
  }
}