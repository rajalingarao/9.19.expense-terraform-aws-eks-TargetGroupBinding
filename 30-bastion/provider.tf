terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 6.37.0" # Terraform AWS provider version
    }
  }
  backend "s3" {
    bucket = "roboshop13-remote-state"
    key    = "tf-aws-eks-tb-bastion"
    region = "us-east-1"
    #dynamodb_table = "roboshop13-locking"
    use_lockfile = true
  }
}
provider "aws" {
  # Configuration options
  region = "us-east-1"
}
