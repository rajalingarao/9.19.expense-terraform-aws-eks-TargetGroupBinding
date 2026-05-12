terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0" # Terraform AWS provider version
    }
  }
  backend "s3" {
    bucket = "roboshop13-remote-state"
    key    = "tf-aws-eks-tb-sg"
    region = "us-east-1"
    dynamodb_table = "roboshop13-locking"
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}
