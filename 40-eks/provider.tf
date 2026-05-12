terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0" # Terraform AWS provider version
    }
  }
  backend "s3" {
    bucket = "roboshop13-remote-state"
    key    = "tf-aws-eks-tb-eks"
    region = "us-east-1"
    dynamodb_table = "roboshop13-locking"
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}
