terraform {
  backend "s3" {
    bucket = "antonicloud-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}