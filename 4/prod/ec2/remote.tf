data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "trainee-project-yauheni-filiuta-tfstate"
    key    = "prod/vpc.tfstate"
    region = "eu-north-1"
  }
}