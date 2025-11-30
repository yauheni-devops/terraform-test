terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "trainee-project-yauheni-tfstate"
    key            = "dev/vpc.tfstate"     # Обратите внимание: для VPC ключ один...
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
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

#backend "s3" {
 #   bucket         = "trainee-project-yauheni-tfstate" # Имя вашего бакета
  #  key            = "dev/vpc.tfstate"                  # Путь внутри бакета
   # region         = "eu-north-1"                        # Ваш регион
    #dynamodb_table = "terraform-locks"                   # Имя вашей таблицы
    #encrypt        = true
#}