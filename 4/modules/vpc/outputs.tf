output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "subnet_ids" {
  description = "List of IDs of created public subnets"
  value       = aws_subnet.public[*].id
}