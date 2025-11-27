# Получаем список доступных зон в текущем регионе
data "aws_availability_zones" "available" {
  state = "available"
}

# Локальная переменная для удобства (берем первые 3 зоны, чтобы не плодить лишнего)
locals {
  # Если в регионе меньше 3 зон, slice автоматически возьмет сколько есть, 
  # но для надежности в eu-north-1 (где их 3) можно использовать names напрямую.
  azs = data.aws_availability_zones.available.names
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" # Всегда хорошая практика фиксировать версию

  name = "trainee-vpc"
  cidr = "10.0.0.0/16"

  # Передаем список зон
  azs = local.azs

  # Магическая строка из задания для генерации списка CIDR
  public_subnets = [for k, v in local.azs : cidrsubnet("10.0.0.0/16", 8, k + 4)]

  # Нам нужны публичные IP для инстансов при запуске
  map_public_ip_on_launch = true

  # Экономим деньги и время (NAT Gateway нужен для приватных сетей, у нас их нет)
  enable_nat_gateway = false
  enable_vpn_gateway = false

  # DNS
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}