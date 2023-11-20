terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "ugl-s3-backend"
    key     = "feature/terraform.tfstate"
    region  = "ap-south-1"
    profile = "ullagalluk"
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = var.region
  profile = var.profile
}

variable "region" {
  default = "ap-south-1"
}
variable "profile" {
  default = "ullagalluk"
}