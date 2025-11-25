variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "trainee-project"
}

variable "env" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "instance_configs" {
  description = "Map of instance names and types"
  type        = map(string)
  default = {
    "backend"  = "t3.micro"
    "frontend" = "t3.nano"
  }
}
variable "name_prefix" {
  description = "Prefix to be used for all resources"
  type        = string
  default     = "web-app" # Значение по умолчанию, если не задано в tfvars
}

