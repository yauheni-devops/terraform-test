terraform {
  backend "s3" {
    bucket         = "trainee-project-yauheni-filiuta-tfstate" # ВСТАВЬТЕ ИМЯ ВАШЕГО БАКЕТА
    key            = "ecr/terraform.tfstate"                 # Путь к файлу внутри бакета
    region         = "eu-north-1"                            # ВАШ РЕГИОН
    dynamodb_table = "terraform-locks"                       # ИМЯ ВАШЕЙ ТАБЛИЦЫ
    encrypt        = true
  }
}