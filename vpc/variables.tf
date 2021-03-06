variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = "list"
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = "list"
  description = "The CIDR block for the private subnet"
}

variable "environment" {
  description = "The environment"
}

variable "app" {
  description = "The application"
}

variable "availability_zones" {
  type        = "list"
  description = "The az that the resources will be launched"
}

variable "profile" {
  description = "AWS profile"
}

variable "region" {
  description = "The region"
}