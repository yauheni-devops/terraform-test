data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"

  # Берем первую подсеть из данных, полученных через remote state
  subnet_id = data.terraform_remote_state.vpc.outputs.subnet_ids[0]

  tags = {
    Name = "dev-trainee-project-ec2"
  }
}