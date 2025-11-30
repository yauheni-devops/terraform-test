# Выводим ID, чтобы слой EC2 мог их прочитать через remote state
output "vpc_id" {
  description = "ID созданной VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "Список ID публичных подсетей"
  value       = module.vpc.subnet_ids
}