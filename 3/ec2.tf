# Получаем AMI (как и раньше)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

# Создаем отдельную Security Group для разрешения Ping
resource "aws_security_group" "allow_ping" {
  name        = "allow_ping_sg"
  description = "Allow ICMP (Ping) traffic"
  # ВАЖНО: Привязываем SG к той VPC, которую создал модуль
  vpc_id      = module.vpc.vpc_id

  # Разрешаем входящий Ping (ICMP)
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Разрешаем SSH (на всякий случай, для дебага)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Разрешаем исходящий трафик
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ping_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"

  # Берем первую публичную подсеть из созданных модулем
  subnet_id = module.vpc.public_subnets[0]

  # Подключаем нашу Security Group
  vpc_security_group_ids = [aws_security_group.allow_ping.id]

  # Явно требуем публичный IP (хотя в модуле мы включили map_public_ip_on_launch, лучше перестраховаться)
  associate_public_ip_address = true

  tags = {
    Name = "ping-test-server"
  }
}

# Выведем IP адрес, чтобы не искать его в консоли
output "server_public_ip" {
  value = aws_instance.ping_server.public_ip
}