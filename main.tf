provider "aws" {
  region  = "us-east-1"
  profile = "trainee"
}

# Этот блок просто запрашивает данные "Кто я?", ничего не создавая
data "aws_caller_identity" "current" {}

# Этот блок выведет ваш Account ID на экран
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "user_arn" {
  value = data.aws_caller_identity.current.arn
}
