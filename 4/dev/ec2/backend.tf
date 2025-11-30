terraform {
  backend "s3" {
    bucket         = "trainee-project-yauheni-filiuta-tfstate"
    key            = "dev/vpc.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}