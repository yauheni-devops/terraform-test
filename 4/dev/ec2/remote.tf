data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "trainee-project-yauheni-filiuta-tfstate"
    key    = "dev/vpc.tfstate"
    region = "eu-north-1"
  }
}