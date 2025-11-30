# Получаем список зон доступности в регионе
data "aws_availability_zones" "available" {
  state = "available"
}

# Используем наш модуль из папки modules/vpc
module "vpc" {
  # Путь к модулю относительно текущей папки (на два уровня вверх)
  source = "../../modules/vpc"

  # Передаем параметры
  name_prefix = "prod-trainee-project"
  vpc_cidr    = "10.0.0.0/16"
  azs         = data.aws_availability_zones.available.names
}