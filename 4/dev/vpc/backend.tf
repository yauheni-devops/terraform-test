terraform {
  backend "s3" {
    bucket         = "trainee-project-yauheni-filiuta-tfstate" # Имя вашего бакета
    key            = "dev/vpc.tfstate"                  # Ключ файла состояния для VPC
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}