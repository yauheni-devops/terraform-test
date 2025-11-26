data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical (создатель Ubuntu)
}
# --- Генерация SSH ключа ---
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.name_prefix}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Сохраняем приватный ключ локально, чтобы можно было подключиться
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/private_key.pem"
  file_permission = "0400"
}

# --- Security Group ---
resource "aws_security_group" "main" {
  name        = "${var.name_prefix}-sg"
  description = "Allow SSH and HTTP"

  # Dynamic block для входящего трафика (порты 22 и 80)
  dynamic "ingress" {
    for_each = [22, 80]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Исходящий трафик (разрешить всё)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- EC2 Instance с for_each ---
resource "aws_instance" "web" {
  for_each = var.instance_configs

  ami           = data.aws_ami.ubuntu.id
  instance_type = each.value

  # Подключаем ключ и SG
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.main.id]

  # Прокидываем скрипт user-data
  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "${var.name_prefix}-${each.key}-ec2"
  }
}