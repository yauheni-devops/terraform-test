resource "aws_ecr_repository" "my_app" {
  name                 = "trainee-app-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}