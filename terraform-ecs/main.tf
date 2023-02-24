#Configure THE PROVIDER FOR TERRAFORM
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

#Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

#Configure STATE FILE TO STORE ON S3
terraform {
  backend "s3" {
    bucket = "statetf"
    key    = "state/terraform.tfstate"
    region = "eu-central-1"
  }
} 