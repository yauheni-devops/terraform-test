# 1. Сначала найдем актуальный образ (AMI) для Amazon Linux 2023
# Это лучше, чем хардкодить ID, так как ID меняются
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# 2. Описываем сам ресурс - виртуальную машину
resource "aws_instance" "my_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro" # t3.micro доступен в eu-north-1 (t2 там часто нет)

  # Тег Name нужен, чтобы видеть красивое имя в консоли AWS
  # Остальные теги (Owner) подтянутся автоматически из provider
  tags = {
    Name = "My-First-Terraform-Server"
  }
}