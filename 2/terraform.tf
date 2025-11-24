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
  region  = "eu-north-1" # Стокгольм
  profile = "trainee"    # Используем созданный ранее профиль

  # Блок default_tags автоматически проставит эти теги ВСЕМ ресурсам
  default_tags {
    tags = {
      Owner   = "Yauheni Filiuta" # <-- ЗАМЕНИТЕ НА СВОЕ ИМЯ И ФАМИЛИЮ
      Project = "Innowise-Lab"
      ManagedBy = "Terraform"
    }
  }
}