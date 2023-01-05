variable "env-name" {
  type = string
   default = "sa-ecs-stage"
}

variable "region" {
  type = string
   default = "eu-central-1"
}


variable "app_count_front" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "app_count_back" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "app_count_admin" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.10.0/24","10.0.11.0/24","10.0.12.0/24"]
}

variable "image_front" {
  type        = string
  default = "escolalms/demo:latest"  
}

variable "image_back" {
  type        = string
  default = "escolalms/api:latest"  
}

variable "image_admin" {
  type        = string
  default = "escolalms/admin:latest"  
}
