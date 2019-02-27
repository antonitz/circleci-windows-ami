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
  description = "The private subnets to use"
}
variable "instance_type" {
  description = "The instance type"
}

/* variable "ssh_access_ips" {
  type        = "list"
  description = "List of IPs to allow SSH access to Bastion"
} */