variable "region" {
  description = "region to deploy"
}

variable "environment" {
  description = "The environment"
}

variable "app" {
  description = "app"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "availability_zones" {
  type        = "list"
  description = "The azs to use"
}

variable "public_subnet_ids" {
  type        = "list"
  description = "The public subnets to use"
}
variable "instance_type" {
  description = "The instance type"
}
