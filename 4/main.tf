# Получаем список доступных зон в текущем регионе
data "aws_availability_zones" "available" {
  state = "available"
}

# Вызов нашего самописного модуля
module "my_vpc" {
  # Указываем путь к папке с модулем
  source = "./modules/vpc"

  # Передаем параметры
  name_prefix = "trainee-project"
  vpc_cidr    = "10.0.0.0/16"
  
  # Передаем список зон из data source
  azs         = data.aws_availability_zones.available.names
}

# Выводим результаты работы модуля в консоль
output "created_vpc_id" {
  value = module.my_vpc.vpc_id
}

output "created_subnet_ids" {
  value = module.my_vpc.subnet_ids
}