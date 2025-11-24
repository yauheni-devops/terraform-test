# 1. Locals (Локальные переменные)
# Это как "формулы" в Excel. Мы берем входные данные (var) и склеиваем их.
# Если project_name="trainee-project" и env="dev", то name_prefix станет "trainee-project-dev"
locals {
  name_prefix = "${var.project_name}-${var.env}"
}

# 2. Data Source (Поиск образа)
# Теперь ищем Ubuntu 24.04 вместо Amazon Linux
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # ID владельца Canonical (разработчики Ubuntu)
  most_recent = true

  filter {
    name   = "name"
    # Ищем конкретную версию Ubuntu Server
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

# 3. Resource (Виртуальная машина)
resource "aws_instance" "my_server" {
  # Ссылка на ID, который нашел блок data выше
  ami = data.aws_ami.ubuntu.id

  # Тип машины берем из переменной (которая задана в dev.tfvars)
  instance_type = var.instance_type

  tags = {
    # Генерируем имя: "trainee-project-dev" + "-ec2"
    # Итоговое имя в консоли будет: trainee-project-dev-ec2
    Name = "${local.name_prefix}-ec2"
  }
}